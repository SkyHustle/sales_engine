require_relative './test_helper'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/load_file'
# require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :data

  def setup
    @data = {
              id:         "1",
              first_name: "Joey",
              last_name:  "Ondricka",
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC"
            }
  end

  def test_it_converts_id_to_integer
    customer = Customer.new(data, nil) 
    assert_equal Fixnum, customer.id.class
    refute_equal String, customer.id.class
  end

  def test_it_has_the_expected_id
    customer = Customer.new(data, nil)
    assert_equal 1, customer.id
    refute_equal 2, customer.id
  end

  def test_it_has_the_expected_first_name
    customer = Customer.new(data, nil)
    assert_equal "Joey", customer.first_name
    refute_equal "Sam", customer.first_name
  end

  def test_it_has_the_expected_last_name
    customer = Customer.new(data, nil)
    assert_equal "Ondricka", customer.last_name
    refute_equal "Ondrik", customer.last_name
  end

  def test_it_has_the_expected_created_at
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
    refute_equal "2012-04-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_the_expected_updated_at
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
    refute_equal "2013-02-27 14:54:09 UTC", customer.updated_at
  end

  def test_it_knows_its_repository
    repo     = CustomerRepository.new(nil)
    customer = Customer.new(data, repo)
    assert repo, customer.repository
  end

  def test_it_is_not_equal_to_a_different_instance_of_repository
    repo     = CustomerRepository.new(nil)
    repo.load_data("./fixtures/customers.csv")
    customer = Customer.new(data,repo)
    assert customer.repository != CustomerRepository.new(nil)
  end

  def test_it_can_talk_to_its_repository
    parent = Minitest::Mock.new
    customer = Customer.new(data, parent)
    parent.expect(:find_invoices, [1, 2], [1])
    assert_equal [1, 2], customer.invoices
    parent.verify
  end
end
