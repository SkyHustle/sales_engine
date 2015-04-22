class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id         = row[:id].to_i
    @first_name = row[:first_name]
    @last_name  = row[:last_name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @repository = repository
  end

  def invoices
    # invoices returns a collection of Invoice instances 
    # associated with this object.
  end
end

