require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :revenue,
              :repository

  def initialize(row, repository)
    @id           = row[:id].to_i
    @item_id      = row[:item_id].to_i
    @invoice_id   = row[:invoice_id].to_i
    @quantity     = row[:quantity].to_i
    # @unit_price   = BigDecimal.new(row[:unit_price])/100
    @created_at   = row[:created_at]
    @updated_at   = row[:updated_at]
    @repository   = repository
    # @revenue      = BigDecimal.new(row[:unit_price])/100 * line[:quantity].to_i
  end
end