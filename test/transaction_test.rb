require_relative '../test/test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
                id:                          "1",
                invoice_id:                  "1",
                credit_card_number:          "4654405418249632",
                credit_card_expiration_date: "",
                result:                      "success",
                created_at:                  "2012-03-27 14:54:09 UTC",
                updated_at:                  "2012-03-27 14:54:09 UTC"
              }
  end

  def test_it_has_the_expected_id
    transaction = Transaction.new(data, nil)
    assert_equal 1, transaction.id
    refute_equal 3, transaction.id
  end

  def test_it_has_the_expected_invoice_id
    transaction = Transaction.new(data, nil)
    assert_equal 1, transaction.invoice_id
    refute_equal 6, transaction.invoice_id
  end

  def test_it_has_the_expected_credit_card_number
    transaction = Transaction.new(data, nil)
    assert_equal 4654405418249632, transaction.credit_card_number
    refute_equal 4654475418249632, transaction.credit_card_number
  end

  def test_it_has_the_expected_credit_card_exp_date
    transaction = Transaction.new(data, nil)
    assert_equal "", transaction.credit_card_expiration_date
    refute_equal "0", transaction.credit_card_expiration_date
  end

  def test_it_has_the_expected_result
    transaction = Transaction.new(data, nil)
    assert_equal "success", transaction.result
    refute_equal "failure", transaction.result
  end

  def test_it_has_the_expected_created_at
    transaction = Transaction.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", transaction.created_at
    refute_equal "2012-03-10 14:54:09 UTC", transaction.created_at
  end

  def test_it_has_the_expected_updated_at
    transaction = Transaction.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", transaction.updated_at
    refute_equal "2012-05-27 14:54:09 UTC", transaction.updated_at
  end

  def test_it_can_talk_to_the_repository_with_invoice
    parent = Minitest::Mock.new
    transaction = Transaction.new(data, parent)
    parent.expect(:find_invoice, "pizza", [1])
    
    assert_equal "pizza", transaction.invoice
    parent.verify
  end
end
