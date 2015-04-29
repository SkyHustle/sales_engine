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
    invoices.flat_map(&:transactions)
  end

  def favorite_merchant
    invoices = successful_transactions.map(&:invoice)
    merchant_id = invoices.group_by(&:merchant_id)
                          .max_by { |merchant_id, invoices| invoices.length}
                          .first
    repository.sales_engine.find_merchant_by_id(merchant_id)
  end

  def successful_transactions
    transactions.find_all(&:successful?)
  end
end