require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'merchant'
require_relative 'load_file'

class MerchantRepository
  attr_reader :merchants, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @merchants = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @merchants = file.map do |line|
      Merchant.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
  end

  def find_by_created_at(created_at)
    find_by_attribute(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by_attribute(:updated_at, updated_at)
  end

  def find_all_by_id(id)
    find_all_by_attribute(:id, id)
  end

  def find_all_by_name(name)
    find_all_by_attribute(:name, name)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def find_all_invoices
    sales_engine.find_all_invoices
  end
  
  def successful_transactions
    find_all_invoices.flat_map(&:transactions)
                     .find_all(&:successful?)
  end

  def revenue(date)
    invoices = successful_transactions.map(&:invoice)
    invoices_on_date = invoices.find_all { |invoice|
                        invoice.created_at == date }
    invoice_ids = invoices_on_date.flat_map(&:id)
    invoice_items = invoice_ids.flat_map { |ids|
      sales_engine.find_invoice_items_by_invoice_id(ids) }
    quantity   = invoice_items.flat_map(&:quantity)
    unit_price = invoice_items.flat_map(&:unit_price)
    quantity.zip(unit_price).map { |q, p| q * p }.reduce(:+)
  end

  private

  def find_by_attribute(attribute, given)
    merchants.detect { |merchant| merchant.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    merchants.select { |merchant| merchant.send(attribute) == given }
  end
end
