require_relative 'load_file'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @invoice_items = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @invoice_items = file.map do |line|
      InvoiceItem.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_item_id(item_id)
    find_by_attribute(:item_id, item_id)
  end

  def find_by_invoice_id(invoice_id)
    find_by_attribute(:invoice_id, invoice_id)
  end

  def find_by_quantity(quantity)
    find_by_attribute(:quantity, quantity)
  end

  def find_by_unit_price(unit_price)
    find_by_attribute(:unit_price, unit_price)
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

  def find_all_by_item_id(item_id)
    find_all_by_attribute(:item_id, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_attribute(:invoice_id, invoice_id)
  end

  def find_all_by_quantity(quantity)
    find_all_by_attribute(:quantity, quantity)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by_attribute(:unit_price, unit_price)
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

  def find_item(item_id)
    sales_engine.find_item_by_id(item_id)
  end

  def create_new_items(items, id)
    items.each do |item|
      grouped_items = items.group_by do |item|
        item
      end
      quantity = grouped_items.map do |item|
        item.count
      end.uniq.flatten.join
      line = {
        id:         "#{invoice_items.last.id + 1}",
        item_id:    item.id,
        invoice_id: id,
        quantity:   quantity,
        unit_price: item.unit_price,
        created_at: "#{Date.new}",
        updated_at: "#{Date.new}"
              }
     new_invoice_item = InvoiceItem.new(line, self)
     invoice_items << new_invoice_item
    end
  end

  private

  def find_by_attribute(attribute, given)
    invoice_items.detect do |invoice_item|
      invoice_item.send(attribute) == given
    end
  end

  def find_all_by_attribute(attribute, given)
    invoice_items.select do |invoice_item|
      invoice_item.send(attribute) == given
    end
  end
end
