require_relative 'load_file'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @customers = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @customers = file.map do |line|
      Customer.new(line, self)
    end
    file.close
  end

  def inspect
  "#<#{self.class} #{@customers.size} rows>"
  end

def all
   customers
  end

  def random
   customers.sample
  end

  def find_by_id(id)
    customers.find { |customers| customers.id == id }
  end

  def find_by_first_name(first_name)
    customers.find { |customers|
      customers.first_name.downcase == first_name.downcase }
  end

  def find_by_last_name(last_name)
    customers.find { |customers|
      customers.last_name.downcase == last_name.downcase }
  end

  def find_by_created_at(created_date)
    customers.find { |customers| customers.created_at == created_date }
  end

  def find_by_updated_at(updated_date)
    customers.find { |customers| customers.updated_at == updated_date }
  end

  def find_all_by_id(id)
    customers.find_all { |customers| customers.id == id
    }
  end

  def find_all_by_first_name(first_name)
    customers.find_all {|customers|
      customers.first_name.downcase == first_name.downcase}
  end

  def find_all_by_last_name(last_name)
    customers.find_all { |customers|
      customers.last_name.downcase == last_name.downcase
    }
  end

  def find_all_by_created_at(created_date)
    customers.find_all { |customers| customers.created_at == created_date }
  end

  def find_all_by_updated_at(updated_date)
    customers.find_all { |customers| customers.created_at == updated_date }
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_customer_id(id)
  end
end
