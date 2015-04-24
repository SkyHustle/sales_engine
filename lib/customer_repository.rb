require_relative 'load_file'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @customers    = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @customers = file.map do |row|
      Customer.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end




  def find_by_first_name(name)
    
  end

  def all
    # all returns all instances
  end

  def random
    # random returns a random instance
  end

  def find_by_id(id)
    
  # find_by_X(match), where X is some attribute, returns a single instance whose X attribute case -insensitive attribute matches the match parameter.For instance, customer_repository.find_by_first_name("Mary") could find a Customer with the first name attribute "Mary" or "mary" but not "Mary Ellen".
  end

  def find_all_by_x
  #     find_all_by_X(match) works just like find_by_X except it returns a collection of all matches.If there is no match, it returns an empty Array.
  end

end

