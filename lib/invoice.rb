require 'date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)
    @id           = line[:id].to_i
    @customer_id  = line[:customer_id].to_i
    @merchant_id  = line[:merchant_id].to_i
    @status       = line[:status]
    # @created_at   = Date.parse(line[:created_at])
    @updated_at   = line[:updated_at]
    @repository   = repository
  end
end