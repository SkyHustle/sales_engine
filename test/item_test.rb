require_relative '../test/test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
require 'date'

class ItemTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
                id:          "1",
                name:        "Item Qui Esse",
                description: "Nihil autem sit",
                unit_price:  "75107",
                merchant_id: "1",
                created_at:  "2012-03-27 14:53:59 UTC",
                updated_at:  "2012-03-27 14:53:59 UTC"
              }
  end

  def test_it_has_the_expected_initialized_id
    item = Item.new(data, nil)

    assert 1, item.id
  end

  def test_it_has_the_expected_initialized_name
    item = Item.new(data, nil)

    assert "Item Qui Esse", item.name
  end

  def test_it_has_the_expected_initialized_description
    item = Item.new(data, nil)

    assert "Nihil autem sit", item.description
  end

  def test_it_has_the_expected_initialized_unit_price
    item = Item.new(data, nil)

    assert 75107, item.unit_price
  end

  def test_it_has_the_expected_initialized_merchant_id
    item = Item.new(data, nil)

    assert 1, item.merchant_id
  end

  def test_it_has_the_expected_initialized_created_at
    item = Item.new(data, nil)

    assert "2012-03-27 14:53:59 UTC", item.created_at
  end

  def test_it_has_the_expected_initialized_updated_at
    item = Item.new(data, nil)

    assert "2012-03-27 14:53:59 UTC", item.updated_at
  end

  def test_it_can_talk_to_the_repository_with_invoices
    parent = Minitest::Mock.new
    item = Item.new(data, parent)
    parent.expect(:find_invoice_items, [1, 2], [1])

    assert_equal [1, 2], item.invoice_items
    parent.verify
  end

  def test_it_can_talk_to_the_repository_with_merchant
    parent = Minitest::Mock.new
    item = Item.new(data, parent)
    parent.expect(:find_merchant, "pizza", [1])

    assert_equal "pizza", item.merchant
    parent.verify
  end

  def test_it_can_find_its_best_day
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    item = sales_engine.item_repository.items[2]

    assert_equal "2012-03-10", item.best_day.to_s
  end

  def test_it_can_find_highest_grossing_item
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    item = sales_engine.item_repository.items[2]

    assert_equal BigDecimal, item.revenue.class    
  end
end