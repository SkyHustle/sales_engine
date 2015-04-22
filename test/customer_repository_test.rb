require_relative './test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_starts_with_an_empty_array_of_customers
    customer_repository = CustomerRepository.new(nil)
    assert_equal [], customer_repository.customers
  end

  def test_it_can_load_customer_data
    customer_repository = CustomerRepository.new(nil)
    customer_repository.load_data("./data/customers.csv")

    assert_equal "Joey", customer_repository.customers.first.first_name
    assert_equal 1, customer_repository.customers.first.id
    assert_equal "Stark", customer_repository.customers[50].last_name

    refute_equal "Sam", customer_repository.customers.first.first_name
    refute_equal 20, customer_repository.customers.first.id
    refute_equal "Samsky", customer_repository.customers[50].last_name
  end




end

