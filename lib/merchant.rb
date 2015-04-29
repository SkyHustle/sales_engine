require 'bigdecimal'
require 'bigdecimal/util'
require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)
    @id         = line[:id].to_i
    @name       = line[:name]
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end

  def successful_transactions
    transactions.find_all(&:successful?)
  end

  def unsuccessful_transactions
    transactions.find_all(&:unsuccessful?)
  end

  def pending_transactions
    all_invoices = invoices
    successful   = successful_transactions.map(&:invoice).uniq
    all_invoices - successful
  end

  def date_convert(created_at)
    created_at.strftime("%a, %m %b %Y")
  end

  def revenue(date = nil)
    if date.nil?
      invoices = successful_transactions.map(&:invoice)
      invoice_ids = invoices.flat_map(&:id)
      invoice_items = invoice_ids.flat_map { |ids|
        repository.sales_engine.find_invoice_items_by_invoice_id(ids) }
      quantity   = invoice_items.flat_map(&:quantity)
      unit_price = invoice_items.flat_map(&:unit_price)
      quantity.zip(unit_price).map { |q, p| q * p }.reduce(:+)
    else
      invoices = successful_transactions.map(&:invoice)
      invoices_on_date = invoices.find_all { |invoice|
                          invoice.created_at == date }
      invoice_ids = invoices_on_date.flat_map(&:id)
      invoice_items = invoice_ids.flat_map { |ids|
        repository.sales_engine.find_invoice_items_by_invoice_id(ids) }
      quantity   = invoice_items.flat_map(&:quantity)
      unit_price = invoice_items.flat_map(&:unit_price)
      quantity.zip(unit_price).map { |q, p| q * p }.reduce(:+)
    end
  end

  def favorite_customer
    invoices = successful_transactions.map(&:invoice)
    customer_id = invoices.group_by(&:customer_id)
                      .max_by { |customer_id, invoices| invoices.length }
                      .first
    repository.sales_engine.find_customer_by_id(customer_id)
  end

  def customers_with_pending_invoices
    customer_id = pending_transactions.flat_map(&:customer_id).uniq
    customer_id.map { |id| repository.sales_engine.find_customer_by_id(id) }
  end
end
