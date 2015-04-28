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
    @created_at   = Date.parse(line[:created_at])
    @updated_at   = line[:updated_at]
    @repository   = repository
  end

  def transactions
    repository.find_transactions(id)
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def items
    invoice_items.map { |invoice_item| invoice_item.item }
  end

  def customer
    repository.find_customer(customer_id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end
end
