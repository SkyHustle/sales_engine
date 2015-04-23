require_relative './test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :data
  def setup
    @data =   {
                id:         "1",
                item_id:    "539",
                invoice_id: "1",
                quantity:   "5",
                unit_price: "13635",
                created_at: "2012-03-27 14:54:09 UTC",
                updated_at: "2012-03-27 14:54:09 UTC"
              }
  end

  def test_it_has_the_expected_initialized_id
    invoice_item = InvoiceItem.new(data, nil)
    assert 1, invoice_item.id
  end
end