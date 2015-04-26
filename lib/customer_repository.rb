require_relative 'load_file'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @customers    = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @customers = file.map do |row|
      Customer.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end

  def all
    customers(&:find_all)
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.find { |customer| customer.id == id }
  end

  def find_by_first_name(first_name)
    customers.find { |customer| customer.first_name.downcase == first_name.downcase }
  end

  def find_by_last_name(last_name)
    customers.find { |customer| customer.last_name.downcase == last_name.downcase }
  end
  
  def find_by_created_at(created_at)
    customers.find { |customer| customer.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    customers.find { |customer| customer.updated_at == updated_at }
  end

  

end

