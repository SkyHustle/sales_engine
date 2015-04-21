require 'csv'

module LoadFile
  def load_file(path)
    CSV.open(path, headers: true, header_converters: :symbol)
  end
end