require_relative './test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new("./fixtures")
    @sales_engine.startup
    # unless @sales_engine
    #   @sales_engine
    # end
  end

  def test_it_can_start_up
    assert sales_engine.customer_repository
  end

  def test_it_can_load_data_at_startup
    sales_engine.customer_repository.load_data("./fixtures/customers.csv")
    refute sales_engine.customer_repository.customers.empty?
  end

  def test_it_can_load_customer_id
    sales_engine.customer_repository.load_data("./fixtures/customers.csv")
    assert_equal 6, sales_engine.customer_repository.customers[5].id
    refute_equal 21, sales_engine.customer_repository.customers[5].id
  end

  def test_it_can_load_item_id
    sales_engine.customer_repository.load_data("./fixtures/items.csv")
    assert_equal 3, sales_engine.item_repository.items[2].id
  end
end