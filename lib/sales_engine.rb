require_relative './customer_repository'

class SalesEngine
  attr_reader :customer_repository,
              :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def startup
    @customer_repository = CustomerRepository.new(self)
    @customer_repository.load_data("#{@filepath}/customers.csv")
  end

end
