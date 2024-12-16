require 'test_helper'

class CarMatchLabelerTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    toyota = create(:brand, :toyota)
    lexus = create(:brand, :lexus)
    create(:user_preferred_brand, user: @user, brand: toyota)
    create(:user_preferred_brand, user: @user, brand: lexus)

    @perfect_match_car = create(:car, :camry, brand: toyota)
    @good_match_car = create(:car, :ls, brand: lexus)
    @null_match_car = create(:car, :versa, brand: create(:brand, :nissan))
  end

  test 'returns perfect_match when car matches both brand and price' do
    labeler = CarMatchLabeler.new(@user, @perfect_match_car)
    assert_equal 'perfect_match', labeler.match_and_label, 'Expected label to be perfect_match'
  end

  test 'returns good_match when car matches brand but not price' do
    labeler = CarMatchLabeler.new(@user, @good_match_car)
    assert_equal 'good_match', labeler.match_and_label, 'Expected label to be good_match'
  end

  test 'returns null when car matches neither brand nor price' do
    labeler = CarMatchLabeler.new(@user, @null_match_car)
    assert_equal 'null', labeler.match_and_label, 'Expected label to be null'
  end
end
