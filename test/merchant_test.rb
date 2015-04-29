require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../test/test_helper'
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

  def test_it_has_the_expected_initialized_id
    merchant = Merchant.new(data, nil)

    assert 1, merchant.id
  end

  def test_it_has_the_expected_initialized_first_name
    merchant = Merchant.new(data, nil)

    assert "Schroeder-Jerde", merchant.name
  end

  def test_it_has_the_expected_initialized_created_at
    merchant = Merchant.new(data, nil)

    assert "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_it_has_the_expected_initialized_updated_at
    merchant = Merchant.new(data, nil)

    assert "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_can_talk_to_the_repository_with_items
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_items, [1, 2], [1])
    assert_equal [1, 2], merchant.items
    parent.verify
  end

  def test_it_can_talk_to_the_repository_with_invoices
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_invoices, [1, 2], [1])
    assert_equal [1, 2], merchant.invoices
    parent.verify
  end

  def test_it_knows_total_revenue_for_a_merchant
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    merchant = sales_engine.merchant_repository.merchants[1]
    assert_equal BigDecimal, merchant.revenue.class
  end

  def test_it_knows_total_revenue_for_a_merchant_on_specific_date
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    merchant = sales_engine.merchant_repository.merchants[1]
    assert_equal BigDecimal.new("8373.29"), merchant.revenue("Fri, 09 Mar 2012")
  end

  def test_it_knows_total_revenue_for_a_merchant_on_specific_other_date
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    merchant = sales_engine.merchant_repository.merchants[1]
    assert_equal BigDecimal, merchant.revenue("Sat, 10 Mar 2012").class
  end      
end
