require_relative 'load_file'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @invoices = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @invoices = file.map do |line|
      Invoice.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_customer_id(customer_id)
    find_by_attribute(:customer_id, customer_id)
  end

  def find_by_merchant_id(merchant_id)
    find_by_attribute(:merchant_id, merchant_id)
  end

  def find_by_status(status)
    find_by_attribute(:status, status)
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

  def find_all_by_customer_id(customer_id)
    find_all_by_attribute(:customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_attribute(:merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    find_all_by_attribute(:status, status)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_customer(id)
    sales_engine.find_customer_by_id(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_id(id)
  end

  private

  def find_by_attribute(attribute, given)
    invoices.detect { |invoice| invoice.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    invoices.select { |invoice| invoice.send(attribute) == given }
  end
end
