require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'merchant'
require_relative 'load_file'

class MerchantRepository
  attr_reader :merchants, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @merchants    = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @merchants = file.map do |row|
      Merchant.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end

  def all
    merchants(&:find_all)
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end
  
  def find_by_created_at(created_at)
    merchants.find { |merchant| merchant.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_by_id(id)
    merchants.find_all { |merchant| merchant.id == id }
  end

  def find_all_by_name(name)
    merchants.find_all { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_created_at(created_at)
    merchants.find_all { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    merchants.find_all { |merchant| merchant.updated_at == updated_at }
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end
end

