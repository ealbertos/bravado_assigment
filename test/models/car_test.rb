require 'test_helper'

class CarTest < ActiveSupport::TestCase
  def setup
    @camry = create(:car, :camry)
    @corolla = create(:car, :corolla)
    @ls = create(:car, :ls)
    @is = create(:car, :is)
    @sentra = create(:car, :sentra)
  end

  test 'by_brand_name scope should return cars with matching brand name' do
    result = Car.by_brand_name('Toyota')
    assert_includes result, @camry
    assert_includes result, @corolla
    refute_includes result, @ls
    refute_includes result, @is
  end

  test 'by_price_range scope should return cars within the price range' do
    result = Car.by_price_range(35_000, 45_000)
    assert_includes result, @camry
    assert_includes result, @corolla
    assert_includes result, @sentra
    refute_includes result, @ls
  end
end
