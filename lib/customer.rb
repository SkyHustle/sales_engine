class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)
    @id         = line[:id].to_i
    @first_name = line[:first_name]
    @last_name  = line[:last_name]
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
    @repository = repository
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    invoices.map do |invoice|
      invoice.transactions
    end.flatten
  end

  def favorite_merchant
    invoices = successful_transactions.map { |transaction| transaction.invoice } 
    invoices.group_by { |invoice| invoice.merchant_id }

    # return invoices with most reacurring merchant_id 
    require 'pry'; binding.pry
  end

  def successful_transactions
    transactions.find_all { |transaction| transaction.successful? }
  end

end

#transactions returns an array of Transaction instances 
# the customer has had

#favorite_merchant returns an instance of Merchant 
# where the customer has conducted the most successful transactions