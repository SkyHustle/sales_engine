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

  def initialize(row, repository)
    @id          = row[:id].to_i
    @name        = row[:name]
    @description = row[:description]
    @unit_price  = row[:unit_price].to_i
    @merchant_id = row[:merchant_id].to_i
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
    @repository  = repository
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(id)
  end
end