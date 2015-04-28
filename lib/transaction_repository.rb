require_relative 'load_file'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @transactions = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @transactions = file.map do |line|
      Transaction.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def all_successful
    transactions.select do |transaction|
      transaction.result == "success"
    end
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_invoice_id(invoice_id)
    find_by_attribute(:invoice_id, invoice_id)
  end

  def find_by_credit_card_number(credit_card_number)
    find_by_attribute(:credit_card_number, credit_card_number)
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by_attribute(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_by_result(result)
    find_by_attribute(:result, result)
  end

  def find_by_created_at(created_at)
    find_by_attribute(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by_attribute(:updated_at, updated_at)
  end

  def find_all_by_id(id)
    find_all_by_attribute(:id, id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_attribute(:invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all_by_attribute(:credit_card_number, credit_card_number)
  end

  def find_all_by_credit_card_expiration_date(ex_date)
    find_all_by_attribute(:credit_card_expiration_date, ex_date)
  end

  def find_all_by_result(result)
    find_all_by_attribute(:result, result)
  end

  def find_all_by_created_at(created_at)
    find_all_by_attribute(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_attribute(:updated_at, updated_at)
  end

  def find_invoice(id)
    sales_engine.find_invoice_by_id(id)
  end

  def create_new_charge(card_info, id)
    card_info = {
      id:                     "#{transactions.last.id + 1}",
      invoice_id:             id,
      credit_card_number:     card_info[:credit_card_number],
      credit_card_expiration: card_info[:credit_card_expiration],
      result:                 card_info[:result],
      created_at:             "#{Date.new}",
      updated_at:             "#{Date.new}"
      }

      new_transaction = Transaction.new(card_info, self)
      transactions << new_transaction
  end

  private

  def find_by_attribute(attribute, given)
    transactions.detect { |transaction| transaction.send(attribute) == given }
  end

  def find_all_by_attribute(attribute, given)
    transactions.select { |transaction| transaction.send(attribute) == given }
  end
end
