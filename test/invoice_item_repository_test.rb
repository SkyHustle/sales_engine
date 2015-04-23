require_relative './test_helper'
require_relative '../lib/invoice_item_repository'
# require 'bigdecimal/util'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_starts_with_an_empty_array
    invoice_item_repository = InvoiceItemRepository.new(nil)
    assert_equal [], invoice_item_repository.invoice_items
  end

  def test_it_can_load_invoice_item_data
    invoice_item_repository = InvoiceItemRepository.new(nil)
    invoice_item_repository.load_data("./fixtures/invoice_item.csv")

    assert_equal 1, invoice_item_repository.invoice_items.first.id
    assert_equal 539, invoice_item_repository.invoice_items.first.item_id
    assert_equal 1, invoice_item_repository.invoice_items[0].invoice_id

    refute_equal "Kyle", invoice_item_repository.invoice_items.first.id
    refute_equal 20, invoice_item_repository.invoice_items.first.item_id
    refute_equal "Braslev", invoice_item_repository.invoice_items[0].invoice_id
  end
end