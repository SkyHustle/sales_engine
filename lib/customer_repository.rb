require_relative 'load_file'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @customers = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @customers = file.map do |row|
      Customer.new(row, self)
    end
    file.close
  end

end

