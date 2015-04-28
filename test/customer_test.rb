require_relative '../test/test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
                id:         "1",
                first_name: "Joey",
                last_name:  "Ondricka",
                created_at: "2012-03-27 14:54:09 UTC",
                updated_at: "2012-03-27 14:54:09 UTC"
              }
  end

  def test_it_has_the_expected_initialized_id
    customer = Customer.new(data, nil)

    assert 1, customer.id
  end

  def test_it_has_the_expected_initialized_first_name
    customer = Customer.new(data, nil)

    assert "Joey", customer.first_name
  end

  def test_it_has_the_expected_initialized_last_name
    customer = Customer.new(data, nil)

    assert "Ondircka", customer.last_name
  end

  def test_it_has_the_expected_initialized_created_at
    customer = Customer.new(data, nil)

    assert "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_the_expected_initialized_updated_at
    customer = Customer.new(data, nil)

    assert "2012-03-27 14:54:09 UTC", customer.updated_at
  end

  def test_it_can_talk_to_the_repository_with_invoice
    parent = Minitest::Mock.new
    customer = Customer.new(data, parent)
    parent.expect(:find_invoices, [1,2], [1])

    assert_equal [1,2], customer.invoices
    parent.verify
  end

  def test_it_can_get_its_transactions
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    customer = sales_engine.customer_repository.customers[0]

    assert_equal 7, customer.transactions.size
  end
end
