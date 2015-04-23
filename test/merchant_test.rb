require 'bigdecimal'
require 'bigdecimal/util'
require_relative './test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
                id:         "1",
                name:       "Schroeder-Jerde",
                created_at: "2012-03-27 14:53:59 UTC",
                updated_at: "2012-03-27 14:53:59 UTC"
              }
  end

  def test_it_has_the_expected_id
    merchant = Merchant.new(data, nil)
    assert_equal 1, merchant.id
    refute_equal 4, merchant.id
  end

  def test_it_has_the_expected_first_name
    merchant = Merchant.new(data, nil)
    assert_equal "Schroeder-Jerde", merchant.name
    refute_equal "Schr-Jerde", merchant.name
  end

  def test_it_has_the_expected_created_at
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    refute_equal "2012-03-17 14:53:59 UTC", merchant.created_at
  end

  def test_it_has_the_expected_updated_at
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
    refute_equal "2012-08-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_can_talk_to_its_repository
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_items, [1, 2], [1])
    assert_equal [1, 2], merchant.items
    parent.verify
  end

  def test_it_can_talk_to_its_repository
    skip
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_invoices, [1, 2], [1])
    assert_equal [1, 2], merchant.invoices
    parent.verify
  end

  def test_it_can_find_its_total_revenue
    skip
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup

    assert_equal "338055.54", sales_engine.merchant_repository.merchants[2].revenue.to_digits
  end

  def test_it_can_find_its_total_revenue_by_date
    skip
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup

    assert_equal "24641.43", sales_engine.merchant_repository.merchants[0].revenue("2012-03-25").to_digits
  end

  def test_it_can_find_its_favorite_customer
    skip
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    merchant = sales_engine.merchant_repository.merchants[50]

    assert_equal "Kuhn", merchant.favorite_customer.last_name
  end

  def test_it_can_find_pending_customers
    skip
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    merchant = sales_engine.merchant_repository.merchants[33]

    assert_equal 1, merchant.customers_with_pending_invoices.count
  end

  def test_it_can_find_its_successful_items
    skip
    sales_engine = SalesEngine.new("./fixtures")
    sales_engine.startup
    merchant = sales_engine.merchant_repository.merchants[14]

    assert_equal 0, merchant.quantity_successful_items
  end
end
