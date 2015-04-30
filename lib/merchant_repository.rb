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
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name == name }
  end

  def find_by_created_at(created_at)
    merchants.find { |merchant| merchant.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_by_id(id)
    merchants.find_all { |merchant| merchant.id == id }
  end

  def find_all_by_name(name)
    merchants.find_all { |merchant| merchant.name == name }
  end

  def find_all_by_created_at(created_at)
    merchants.find_all { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    merchants.find_all { |merchant| merchant.updated_at == updated_at }
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

  def most_revenue(x)
     merchants.sort_by do |merchant|
      merchant.revenue
    end.reverse.first(x)
  end

  def most_items(x)
    merchants.sort_by do |merchant|
      merchant.quantity_successful_items
    end.reverse.first(x)
  end
end