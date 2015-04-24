require_relative '../test/test_helper'
require_relative '../lib/invoice_item_repository'
# require 'bigdecimal/util'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_starts_out_as_empty
    invoice_item_repository = InvoiceItemRepository.new(nil)
    assert_equal [], invoice_item_repository.invoice_items
  end

  def test_it_can_load_invoice_item_data
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")

    assert_equal 1, invoice_item_repository.invoice_items.first.id
    assert_equal 539, invoice_item_repository.invoice_items.first.item_id
    assert_equal 1, invoice_item_repository.invoice_items[0].invoice_id

    refute_equal "Kyle", invoice_item_repository.invoice_items.first.id
    refute_equal 20, invoice_item_repository.invoice_items.first.item_id
    refute_equal "Braslev", invoice_item_repository.invoice_items[0].invoice_id
  end

  def test_it_contains_all_invoice_items
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")
    refute invoice_item_repository.invoice_items.empty?
  end

  def test_it_can_return_random_sample_of_invoice_item
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")
    assert invoice_item_repository.random
  end

    def test_it_can_find_by_item_id
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")
    result = invoice_item_repository.find_by_item_id(535)
    # binding.pry
    assert_equal 535, result.item_id
  end

  def test_it_can_find_by_invoice_id
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")
    result = invoice_item_repository.find_by(:invoice_id, 1)

    assert_equal 1, result.invoice_id
  end

  def test_it_can_find_by_quantity
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")
    result = invoice_item_repository.find_all_by(:quantity, 9)

    assert_equal 7, result.count
  end

  def test_it_can_find_by_unit_price
    skip
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_by_unit_price(BigDecimal.new(23324)/100)

    assert_equal "233.24", result.unit_price.to_digits
  end

  def test_it_can_find_by_created_at
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_by(:created_at, "2012-03-27 14:54:09 UTC")

    assert_equal "2012-03-27 14:54:09 UTC", result.created_at
  end

  def test_it_can_find_by_updated_at
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_by(:updated_at, "2012-03-27 14:54:09 UTC")

    assert_equal "2012-03-27 14:54:09 UTC", result.updated_at
  end

  def test_it_can_find_all_by_id
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_all_by_id(4)

    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_item_id
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_all_by_item_id(523)

    assert_equal 10, result.count
  end

  def test_it_can_find_all_by_invoice_id
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")
    result = invoice_item_repository.find_all_by_invoice_id(1)

    assert_equal 8, result.count
  end

  def test_it_can_find_all_by_quantity
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_items.csv")
    result = invoice_item_repository.find_all_by(:quantity, 7)

    assert_equal 4, result.count
  end

  def test_it_can_find_all_by_unit_price
    skip
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_all_by_unit_price(BigDecimal.new(72018)/100)

    assert_equal 33, result.count
  end

  def test_it_can_find_all_by_created_at
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")

    assert_equal 97, result.count
  end

  def test_it_can_find_all_by_updated_at
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./data/invoice_items.csv")
    result = invoice_item_repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")

    assert_equal 97, result.count
  end

end