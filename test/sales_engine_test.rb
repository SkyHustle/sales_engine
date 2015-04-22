require_relative './test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new("./data")
    @sales_engine.startup
    unless @sales_engine
      @sales_engine
    end
  end

  def test_it_exists
    assert SalesEngine.new("./data")
  end

  def test_it_can_start_up
    assert sales_engine.customer_repository
  end

  def test_it_can_load_data_at_startup
    sales_engine.customer_repository.load_data("./data/customers.csv")

    refute sales_engine.customer_repository.customers.empty?
  end
end