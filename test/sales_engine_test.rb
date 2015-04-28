require_relative '../test/test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new("./data")
    @sales_engine.startup
    unless @sales_engine
      @sales_engine
    end
  end

  def test_it_exists
    assert SalesEngine.new("./data")
  end

  def test_it_can_start_up
    assert sales_engine.customer_repository
    assert sales_engine.merchant_repository
    assert sales_engine.transaction_repository
    assert sales_engine.item_repository
    assert sales_engine.invoice_repository
    assert sales_engine.invoice_item_repository
  end

  def test_it_can_load_data_at_startup
    sales_engine.customer_repository.load_data("./data/customers.csv")

    refute sales_engine.customer_repository.customers.empty?
  end

  def test_it_can_load_customer_data_at_startup
    sales_engine.customer_repository.load_data("./data/customers.csv")

    assert_equal "Joey", sales_engine.customer_repository.customers.first.first_name
  end

  def test_it_can_load_invoice_items_data_at_startup
    sales_engine.invoice_item_repository.load_data("./data/invoice_items.csv")

    assert_equal 539, sales_engine.invoice_item_repository.invoice_items.first.item_id
  end

  def test_it_can_load_invoices_data_at_startup
    sales_engine.invoice_repository.load_data("./data/invoices.csv")

    assert_equal 26, sales_engine.invoice_repository.invoices.first.merchant_id
  end

  def test_it_can_load_items_data_at_startup
    sales_engine.item_repository.load_data("./data/items.csv")

    assert_equal "Item Qui Esse", sales_engine.item_repository.items.first.name
  end

  def test_it_can_load_merchants_data_at_startup
    sales_engine.merchant_repository.load_data("./data/merchants.csv")

    assert_equal "Schroeder-Jerde", sales_engine.merchant_repository.merchants.first.name
  end

  def test_it_can_load_transactions_data_at_startup
    sales_engine.transaction_repository.load_data("./data/transactions.csv")

    assert_equal "4654405418249632", sales_engine.transaction_repository.transactions.first.credit_card_number
  end

  def test_it_can_find_items_by_merchant_id
    items_by_merchant = sales_engine.find_items_by_merchant_id(2)

    assert_equal 38, items_by_merchant.count
  end

  def test_it_can_find_invoices_by_merchant_id
    invoices_by_merchant = sales_engine.find_invoices_by_merchant_id(3)

    assert_equal 43, invoices_by_merchant.count
  end

  def test_it_can_find_invoiceitems_by_item_id
    invoice_items_by_item = sales_engine.find_invoices_by_merchant_id(3)

    assert_equal 43, invoice_items_by_item.count
  end

  def test_it_can_find_merchant_by_item_id
    merchant = sales_engine.find_merchant_by_id(3)

    assert_equal "Willms and Sons", merchant.name
  end

  def test_it_can_find_invoice_by_transaction
    invoice = sales_engine.find_invoice_by_id(3)

    assert_equal 3, invoice.id
  end

  def test_it_can_find_ivoices_by_customer
    invoices_by_customer_id = sales_engine.find_invoices_by_customer_id(3)

    assert_equal 4, invoices_by_customer_id.count
  end

  def test_it_can_find_invoice_by_id
    invoice = sales_engine.find_invoice_by_id(3)

    assert_equal "shipped", invoice.status
  end

  def test_it_can_find_item_by_id
    item = sales_engine.find_item_by_id(3)

    assert_equal "Item Ea Voluptatum", item.name
  end

  def test_it_can_find_transactions_with_invoice_id
    transactions_by_invoice = sales_engine.find_transactions_by_invoice_id(34)

    assert_equal 3, transactions_by_invoice.count
  end

  def test_it_can_find_customer_by_id
    customer = sales_engine.find_customer_by_id(3)

    assert_equal "Toy", customer.last_name
  end

  def test_it_can_find_items_by_invoice_item
    invoice_items_by_id = sales_engine.find_invoice_items_by_invoice_id(3)

    assert_equal 8, invoice_items_by_id.count
  end
end
