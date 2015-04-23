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

end
