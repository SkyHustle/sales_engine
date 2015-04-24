module RepoHelper
  def find_by(attribute, value)
      invoice_items.find { |item| item.send(attribute) == value }
  end

  def method_missing(method_id, args)
    if method_id.to_s.include?("find_by_")
      attribute = method_id.to_s.gsub!("find_by_", "").to_sym
      value     = args
      find_by(attribute, value)
    elsif method_id.to_s.include?("find_all_by")
      attribute = method_id.to_s.gsub!("find_all_by", "").to_sym
      value     = args
      find_by(attribute, value)
    end
  end
end