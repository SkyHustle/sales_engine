require_relative 'load_file'
require_relative 'item'

class ItemRepository
  attr_reader :items, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @items = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @items = file.map do |line|
      Item.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    items.find { |items| items.id == id }
  end

  def find_by_name(name)
    items.find { |items| items.name.downcase == name.downcase }
  end

  def find_by_description(description)
    items.find { |items| items.description.downcase == description.downcase}
  end

  def find_by_unit_price(unit_price)
    items.find { |items| items.unit_price == unit_price}
  end

  def find_by_merchant_id(id)
    items.find { |items| items.merchant_id == id }
  end

  def find_by_created_at(created_date)
    items.find { |items| items.created_at == created_date }
  end

  def find_by_updated_at(updated_date)
    items.find { |items| items.updated_at == updated_date }
  end

  def find_all_by_id(id)
    items.find_all { |items| items.id == id }
  end

  def find_all_by_name(name)
    items.find_all { |items| items.name.downcase == name.downcase }
  end

  def find_all_by_description(description)
    items.find_all { |items|
      items.description.downcase == description.downcase }
  end

  def find_all_by_unit_price(price)
    items.find_all { |items| items.unit_price == price }
  end

  def find_all_by_merchant_id(id)
    items.find_all { |items| items.merchant_id == id }
  end

  def find_all_by_created_at(created_date)
    items.find_all { |items| items.created_at == created_date }
  end

  def find_all_by_updated_at(updated_date)
    items.find_all { |items| items.updated_at == updated_date }
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_id(id)
  end

  def find_all_merchants
    sales_engine.find_all_merchants
  end

  def most_revenue(x)
    items.sort_by do |item|
      item.revenue
    end.reverse.first(x)
  end

  def most_items(x)
    items.sort_by do |item|
      item.quantity_sold
    end.reverse.first(x)
  end
end
