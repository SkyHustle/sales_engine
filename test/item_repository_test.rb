require_relative './test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_it_starts_with_an_empty_array_of_items
    item_repository = ItemRepository.new(nil)
    assert_equal [], item_repository.items
  end

  def test_it_can_load_item_data
    item_repository = ItemRepository.new(nil)
    item_repository.load_data("./fixtures/items.csv")

    assert_equal "Item Qui Esse", item_repository.items.first.name
    assert_equal 1, item_repository.items.first.id
    assert_equal "2012-03-27 14:53:59 UTC", item_repository.items[0].updated_at

    refute_equal "Brook", item_repository.items.first.name
    refute_equal 20, item_repository.items.first.id
    refute_equal "Davenport", item_repository.items[2].description
  end

  def test_it_can_load_item_from_middle_of_repo
    item_repository = ItemRepository.new(nil)
    item_repository.load_data("./fixtures/items.csv")

    assert_equal "Item Nemo Facere", item_repository.items[3].name
    assert_equal 4, item_repository.items[3].id
    assert_equal "2012-03-27 14:53:59 UTC", item_repository.items[3].updated_at

    refute_equal "Hokee", item_repository.items[3].name
    refute_equal 35, item_repository.items[3].id
    refute_equal "Pokee", item_repository.items[3].updated_at
  end
end