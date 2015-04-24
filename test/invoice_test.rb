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

  def test_it_has_the_expected_id
    invoice = Invoice.new(data, nil)
    assert_equal 1, invoice.id
    refute_equal 5, invoice.id
  end

  def test_it_has_the_expected_customer_id
    invoice = Invoice.new(data, nil)
    assert_equal 1, invoice.customer_id
    refute_equal 2, invoice.customer_id
  end

  def test_it_has_the_expected_merchant_id
    invoice = Invoice.new(data, nil)
    assert_equal 26, invoice.merchant_id
    refute_equal 6, invoice.merchant_id
  end

  def test_it_has_the_expected_created_at
    invoice = Invoice.new(data, nil)
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
    refute_equal "2012-12-25 09:54:09 UTC", invoice.created_at
  end

  def test_it_has_the_expected_updated_at
    invoice = Invoice.new(data, nil)
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
    refute_equal "2012-03-05 09:54:09 UTC", invoice.updated_at
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

  def test_it_can_talk_to_the_repository_with_items
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_items, [1, 2], [1])
    assert_equal [1, 2], invoice.items
    parent.verify
  end

  def test_it_can_talk_to_the_repository_with_customer
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_customer, [1, 2], [1])
    assert_equal [1, 2], invoice.customer
    parent.verify
  end

  def test_it_can_talk_to_the_repository_with_customer
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_merchant, [1, 2], [1])
    assert_equal [1, 2], invoice.merchant
    parent.verify
  end
end
