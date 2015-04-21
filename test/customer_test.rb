require_relative './test_helper'
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
    assert_equal 1, customer.id
  end

end