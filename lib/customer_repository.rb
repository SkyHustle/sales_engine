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
    find_by_attribute(:id, id)
  end

  def find_by_first_name(first_name)
    customers.detect do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_by_last_name(last_name)
    customers.detect do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def find_by_created_at(created_at)
    find_by_attribute(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by_attribute(:updated_at, updated_at)
  end

  def find_all_by_id(id)
    find_all_by_attribute(:id, id)
  end

  def find_all_by_first_name(first_name)
    customers.select do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    customers.select do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_customer_id(id)
  end

  private

  def find_by_attribute(attribute, given)
    customers.detect { |customer| customer.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    customers.select { |customer| customer.send(attribute) == given }
  end
end
