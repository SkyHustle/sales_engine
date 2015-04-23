require_relative './test_helper'
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

end
