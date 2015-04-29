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

  def date_convert(created_at)
    created_at.strftime("%a, %m %b %Y")
  end

  def revenue(date = nil)
    if date.nil?
      invoices = successful_transactions.map(&:invoice)
      invoice_ids = invoices.flat_map(&:id)
      invoice_items = invoice_ids.flat_map { |ids| repository.sales_engine.find_invoice_items_by_invoice_id(ids) }
      quantity   = invoice_items.flat_map(&:quantity)
      unit_price = invoice_items.flat_map(&:unit_price)
      quantity.zip(unit_price).map { |q, p| q * p }.reduce(:+)
    else
      invoices = successful_transactions.map(&:invoice)
      converted_date_keys = invoices.group_by { |invoice| 
        invoice.created_at.strftime("%a, %d %b %Y") }
        
      invoice_ids = converted_date_keys[date].flat_map(&:id)
      
      invoice_items = invoice_ids.flat_map { |ids| 
        repository.sales_engine.find_invoice_items_by_invoice_id(ids) }

      quantity   = invoice_items.flat_map(&:quantity)
      unit_price = invoice_items.flat_map(&:unit_price)
      quantity.zip(unit_price).map { |q, p| q * p }.reduce(:+)
    end
  end



end
