require_relative '../test/test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  def test_it_starts_with_an_empty_array_of_transactions
    transaction_repository = TransactionRepository.new(nil)

    assert_equal [], transaction_repository.transactions
  end

  def test_it_can_load_data_to_transaction
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")

    assert_equal "4654405418249632",transaction_repository.transactions.first.credit_card_number
    assert_equal 1, transaction_repository.transactions.first.id
    assert_equal "success", transaction_repository.transactions[20].result
  end

  def test_it_can_return_all_transactions
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")

    refute transaction_repository.transactions.empty?
  end

  def test_it_can_return_random_sample
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")

    assert transaction_repository.random
  end

  def test_it_can_find_by_id
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_by_id(4)

    assert_equal 4, result.id
  end

  def test_it_can_find_by_invoice_id
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_by_invoice_id(7)

    assert_equal 7, result.invoice_id
  end

  def test_it_can_find_credit_card_number
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_by_credit_card_number("4515551623735607")

    assert_equal "4515551623735607", result.credit_card_number
  end

  def test_it_can_find_by_result
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_by_result("success")

    assert_equal "success", result.result
  end

  def test_it_can_find_by_created_at
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository .find_by_created_at("2012-03-27 14:54:10 UTC")

    assert_equal "2012-03-27 14:54:10 UTC", result.created_at
  end

  def test_it_can_find_by_updated_at
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository .find_by_updated_at("2012-03-27 14:54:10 UTC")

    assert_equal "2012-03-27 14:54:10 UTC", result.updated_at
  end

  def test_it_can_find_all_by_id
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_all_by_id(4)

    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_invoice_id
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_all_by_invoice_id(35)

    assert_equal 2, result.count
  end

  def test_it_can_find_all_by_credit_card_number
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_all_by_credit_card_number("4763141973880496")

    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_result
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_all_by_result("failed")

    assert_equal 947, result.count
  end

  def test_it_can_find_all_by_created_at
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")

    assert_equal 20, result.count
  end

  def test_it_can_find_all_by_updated_at
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")

    assert_equal 20, result.count
  end

  def test_it_can_talk_to_the_repository_with_invoice
    parent = Minitest::Mock.new
    transaction_repository = TransactionRepository.new(parent)
    parent.expect(:find_invoice_by_id, "pizza", [1])

    assert_equal "pizza", transaction_repository.find_invoice(1)
    parent.verify
  end

  def test_it_can_find_all_successful_transactions
    transaction_repository = TransactionRepository.new(nil)
    transaction_repository.load_data("./data/transactions.csv")
    result = transaction_repository.all_successful

    assert_equal 4648, result.count
  end

  def test_it_can_create_a_new_transaction
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    sales_engine.transaction_repository.create_new_charge(credit_card_number: "4444333322221111",
               credit_card_expiration: "10/13", result: "success")

    assert_equal "success", sales_engine.transaction_repository.transactions.last.result
  end
end
