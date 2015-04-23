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
    # @unit_price  = BigDecimal.new(row[:unit_price])/100
    @merchant_id = row[:merchant_id].to_i
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
    @repository  = repository
  end
end