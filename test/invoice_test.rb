require_relative '../test/test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
                id:          "1",
                customer_id: "1",
                merchant_id: "26",
                status:      "shipped",
                created_at: "2012-03-25 09:54:09 UTC",
                updated_at: "2012-03-25 09:54:09 UTC"
              }
  end

  def test_it_has_the_expected_initialized_id
    invoice = Invoice.new(data, nil)

    assert 1, invoice.id
  end

  def test_it_has_the_expected_initialized_customer_id
    invoice = Invoice.new(data, nil)

    assert "1", invoice.customer_id
  end

  def test_it_has_the_expected_initialized_merchant_id
    invoice = Invoice.new(data, nil)

    assert "26", invoice.merchant_id
  end

  def test_it_has_the_expected_initialized_created_at
    invoice = Invoice.new(data, nil)

    assert "2012-03-25 09:54:09 UTC", invoice.created_at
  end

  def test_it_has_the_expected_initialized_updated_at
    invoice = Invoice.new(data, nil)

    assert "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

  def test_it_can_talk_to_the_repository_with_transactions
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_transactions, [1, 2], [1])
    assert_equal [1, 2], invoice.transactions
    parent.verify
  end

  def test_it_can_talk_to_the_repository_with_invoice_items
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_invoice_items, [1, 2], [1])
    assert_equal [1, 2], invoice.invoice_items
    parent.verify
  end

  def test_it_can_talk_to_the_repository_with_invoice_items
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_invoice_items, [1, 2], [1])
    assert_equal [1, 2], invoice.invoice_items
    parent.verify
  end

  def test_it_can_talk_to_the_repository_with_customer
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_customer, [1, 2], [1])
    assert_equal [1, 2], invoice.customer
    parent.verify
  end

  def test_it_can_get_its_items
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup

    assert_equal 8, sales_engine.invoice_repository.invoices[0].items.size
  end
end
