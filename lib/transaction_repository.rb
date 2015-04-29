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

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == id}
  end

  def find_by_invoice_id(id)
    transactions.find { |transaction| transaction.invoice_id == id }
  end

  def find_by_credit_card_number(cc)
    transactions.find { |transaction| transaction.credit_card_number == cc}
  end

  def find_by_credit_card_expiration_date(cc_date)
    transactions.find { |transaction|
      transaction.credit_card_expiration_date == cc_date}
  end

  def find_by_result(result)
    transactions.find { |transaction| transaction.result == result}
  end

  def find_by_created_at(created_date)
    transactions.find { |transaction| transaction.created_at == created_date }
  end

  def find_by_updated_at(updated_date)
    transactions.find { |transaction| transaction.updated_at == updated_date }
  end

  def find_all_by_id(id)
    transactions.find_all {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(id)
    transactions.find_all {|transaction| transaction.invoice_id == id}
  end

  def find_all_by_credit_card_number(cc)
    transactions.find_all { |transaction| transaction.credit_card_number == cc }
  end

  def find_all_by_credit_card_expiration_date(cc)
    transactions.find_all { |transaction|
      transaction.credit_card_expiration_date == cc }
  end

  def find_all_by_result(result)
    transactions.find_all { |transaction| transaction.result == result }
  end

  def find_all_by_created_at(created_date)
    transactions.find_all { |transaction|
      transaction.created_at == created_date }
  end

  def find_all_by_updated_at(updated_date)
    transactions.find_all { |transaction|
      transaction.updated_at == updated_date }
  end

  def find_invoice(id)
    sales_engine.find_invoice_by_id(id)
  end

  def all_successful
    transactions.select do |transaction|
      transaction.result == "success"
    end
  end

  def create_new_charge(card_info, id=nil)
    @invoice_id = id
    line = {
      id:          "#{transactions.last.id + 1}",
      invoice_id:  "#{@invoice_id}",
      credit_card_number: card_info[:credit_card_number],
      credit_card_expiration_date: card_info[:credit_card_expiration_date],
      result:      card_info[:result],
      created_at:  "#{Date.new}",
      updated_at:  "#{Date.new}",
            }

    new_trans = Transaction.new(line, self)
    transactions << new_trans
  end
end
