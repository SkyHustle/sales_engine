require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../test/test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_it_starts_with_an_empty_array_of_merchants
    merchant_repository = MerchantRepository.new(nil)

    assert_equal [], merchant_repository.merchants
  end


  def test_it_can_load_data_to_merchant
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")

    assert_equal "Schroeder-Jerde", merchant_repository.merchants.first.name
    assert_equal 1, merchant_repository.merchants.first.id
    assert_equal "Leffler, Rice and Leuschke", merchant_repository.merchants[20].name
  end

  def test_it_can_return_all_merchants
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")

    refute merchant_repository.merchants.empty?
  end

  def test_it_can_return_random_sample
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")

    assert merchant_repository.random
  end

  def test_it_can_find_by_id
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_by_id(4)

    assert_equal 4, result.id
  end

  def test_it_can_find_by_name
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_by_name("Kozey Group")

    assert_equal "Kozey Group", result.name
  end

  def test_it_can_find_by_created_at
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")

    assert_equal "2012-03-27 14:53:59 UTC", result.created_at
  end

  def test_it_can_find_by_updated_at
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")

    assert_equal "2012-03-27 14:53:59 UTC", result.updated_at
  end

  def test_it_can_find_all_by_id
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_all_by_id(4)

    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_name
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_all_by_name("Brown Inc")

    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_created_at
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")

    assert_equal 9, result.count
  end

  def test_it_can_find_all_by_updated_at
    merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data("./data/merchants.csv")
    result = merchant_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")

    assert_equal 8, result.count
  end

  def test_it_can_access_parent_with_items
    parent = Minitest::Mock.new
    merchant_repository = MerchantRepository.new(parent)
    parent.expect(:find_items_by_merchant_id, [1, 2], [1])

    assert_equal [1, 2], merchant_repository.find_items(1)
    parent.verify
  end

  def test_it_can_access_parent_with_invoices
    parent = Minitest::Mock.new
    merchant_repository = MerchantRepository.new(parent)
    parent.expect(:find_invoices_by_merchant_id, [1, 2], [1])

    assert_equal [1, 2], merchant_repository.find_invoices(1)
    parent.verify
  end

  def test_it_can_find_most_revenue
    skip
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    result = sales_engine.merchant_repository.most_revenue(2)

    assert_equal 2, result.count
    assert result.is_a?(Array)
    assert result[1].is_a?(Merchant)
  end

  def test_it_can_find_most_items
    skip
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    result = sales_engine.merchant_repository.most_items(1)

    assert_equal "Balistreri, Schaefer and Kshlerin", result.first.name
  end

  def test_it_can_find_total_revenue_by_date
    skip
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    result = sales_engine.merchant_repository.revenue("Monday, 2012-03-25")

    assert_equal "21067.77", result.to_digits
  end

end
