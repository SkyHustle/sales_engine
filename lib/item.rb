require 'bigdecimal/util'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)
    @id          = line[:id].to_i
    @name        = line[:name]
    @description = line[:description]
    @unit_price  = BigDecimal.new(line[:unit_price])/100
    @merchant_id = line[:merchant_id].to_i
    @created_at  = line[:created_at]
    @updated_at  = line[:updated_at]
    @repository  = repository
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def best_day
    maximum_item = invoice_items.max_by { |invoice_item| invoice_item.quantity }
    maximum_item.invoice.created_at
  end

  def revenue
    successful_invoice_items = invoice_items.find_all(&:successful?)
    successful_invoice_items.map(&:quantity).reduce(0, :+) * unit_price
  end

  def quantity_sold
    successful_invoice_items = invoice_items.find_all(&:successful?)
    successful_invoice_items.map(&:quantity).reduce(0, :+)
  end

end
