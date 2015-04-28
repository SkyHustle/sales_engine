require_relative '../test/test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_starts_with_an_empty_array_of_invoices
    invoice_repository = InvoiceRepository.new(nil)

    assert_equal [], invoice_repository.invoices
  end


  def test_it_can_load_data_to_invoice
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./fixtures/invoices.csv")

    assert_equal 1, invoice_repository.invoices.first.customer_id
    assert_equal 1, invoice_repository.invoices.first.id
    assert_equal 26, invoice_repository.invoices.first.merchant_id
  end

  def test_it_can_return_all_invoices
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")

    refute invoice_repository.invoices.empty?
  end

  def test_it_can_return_random_sample
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")

    assert invoice_repository.random
  end

  def test_it_can_find_by_id
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_by_id(4)

    assert_equal 4, result.id
  end

  def test_it_can_find_by_customer_id
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_by_customer_id(1)

    assert_equal 1, result.customer_id
  end

  def test_it_can_find_by_merchant_id
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_by_merchant_id(1)

    assert_equal 1, result.merchant_id
  end

  def test_it_can_find_by_status
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_by_status("shipped")

    assert_equal "shipped", result.status
  end

  def test_it_can_find_by_created_at
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_by_created_at(Date.parse("2012-03-25 09:54:09 UTC"))

    assert_equal 1, result.id
  end

  def test_it_can_find_by_updated_at
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_by_updated_at("2012-03-06 21:54:10 UTC")

    assert_equal "2012-03-06 21:54:10 UTC", result.updated_at
  end

  def test_it_can_find_all_by_id
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_all_by_id(4)

    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_customer_id
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_all_by_customer_id(523)

    assert_equal 10, result.count
  end

  def test_it_can_find_all_by_merchant_id
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_all_by_merchant_id(1)

    assert_equal 59, result.count
  end

  def test_it_can_find_all_by_status
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_all_by_status("shipped")

    assert_equal 4843, result.count
  end

  def test_it_can_find_all_by_created_at
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")

    assert_equal 0, result.count
  end

  def test_it_can_find_all_by_updated_at
    invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data("./data/invoices.csv")
    result = invoice_repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")

    assert_equal 0, result.count
  end

  def test_it_can_talk_to_the_parent_with_transactions
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent)
    parent.expect(:find_invoice_items_by_invoice_id, [1, 2], [1])

    assert_equal [1, 2], invoice_repository.find_invoice_items(1)
    parent.verify
  end

  def test_it_can_talk_to_the_parent_with_invoice_items
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent)
    parent.expect(:find_transactions_by_invoice_id, "pizza", [1])

    assert_equal "pizza", invoice_repository.find_transactions(1)
    parent.verify
  end

  def test_it_can_talk_to_the_parent_with_customer
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent)
    parent.expect(:find_invoice_items_by_invoice_id, "pizza", [1])

    assert_equal "pizza", invoice_repository.find_invoice_items(1)
    parent.verify
  end

  def test_it_can_talk_to_the_parent_with_merchant
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent)
    parent.expect(:find_merchant_by_id, "pizza", [1])

    assert_equal "pizza", invoice_repository.find_merchant(1)
    parent.verify
  end

  def test_it_can_talk_to_the_parent_with_new_charge
    parent = Minitest::Mock.new
    invoice_repository = InvoiceRepository.new(parent)
    parent.expect(:new_charge_with_invoice_id, "pizza", [1, 2])

    assert_equal "pizza", invoice_repository.new_charge(1, 2)
    parent.verify
  end

  def test_it_can_create_an_invoice
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    sales_engine.invoice_repository.create(customer: sales_engine.invoice_repository.invoices[0].customer, merchant: sales_engine.invoice_repository.invoices[14].merchant, status: "shipped", items: sales_engine.invoice_repository.invoices[0].items)

    assert_equal 4844, sales_engine.invoice_repository.invoices.last.id
  end
end
