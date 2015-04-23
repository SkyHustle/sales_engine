require_relative './test_helper'
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

  def test_it_has_the_expected_id_using_actual_data
    skip
    item = Item.new(data, nil)
    assert 1, item.id
  end

  def test_it_has_the_expected_id
    item = Item.new(data, nil)
    assert 1, item.id
  end
end