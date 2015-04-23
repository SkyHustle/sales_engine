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
end