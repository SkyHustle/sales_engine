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

  def test_it_has_the_expected_id
    item = Item.new(data, nil)
    assert_equal 1, item.id
    refute_equal 3, item.id
  end

  def test_it_has_the_expected_name
    item = Item.new(data, nil)
    assert_equal "Item Qui Esse", item.name
    refute_equal "Item Qui E", item.name
  end

  def test_it_has_the_expected_description
    item = Item.new(data, nil)
    assert_equal "Nihil autem sit", item.description
    refute_equal "Nihil sit", item.description
  end

  def test_it_has_the_expected_unit_price
    item = Item.new(data, nil)
    assert_equal 75107, item.unit_price
  end

  def test_it_has_the_expected_merchant_id
    item = Item.new(data, nil)
    assert_equal 1, item.id
    refute_equal 5, item.id
  end

  def test_it_has_the_expected_created_at
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
    refute_equal " 14:53:59 UTC", item.created_at
  end

  def test_it_has_the_expected_updated_at
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
    refute_equal "2012-03-27 14:53:59", item.updated_at
  end

  def test_it_can_talk_to_its_repository
    parent = Minitest::Mock.new
    item = Item.new(data, parent)
    parent.expect(:find_invoice_items, [1, 2], [1])
    assert_equal [1, 2], item.invoice_items
    parent.verify
  end

  def test_it_can_talk_to_its_repository
    parent = Minitest::Mock.new
    item = Item.new(data, parent)
    parent.expect(:find_merchant, [1, 2], [1])
    assert_equal [1, 2], item.merchant
    parent.verify
  end
end