require 'test_helper'

class CarsFilterServiceTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    toyota = create(:brand, :toyota)
    lexus = create(:brand, :lexus)
    nissan = create(:brand, :nissan)
    create(:user_preferred_brand, user: @user, brand: toyota)
    create(:user_preferred_brand, user: @user, brand: lexus)
    @sentra = create(:car, :sentra, brand: nissan)
    @versa = create(:car, :versa, brand: nissan)
    @camry = create(:car, :camry, brand: toyota)
    @corolla = create(:car, :corolla, brand: toyota)
    @ls = create(:car, :ls, brand: lexus)
    @is = create(:car, :is, brand: lexus)

    @recommendation_service = CarRecomendationService.new
    stub_car_recommendations_api
  end

  test 'should filter cars by brand and price range and return sorted results' do
    service = CarsFilterService.new({ query: 'Lexus' }, @user)

    filtered_cars = service.call
    filtered_cars.each do |car|
      puts car.label
      puts car.price
      puts '========================'
    end

    assert_equal 2, filtered_cars.count
    assert_equal @is.model, filtered_cars.first.model
    assert_equal @ls.model, filtered_cars.last.model
  end

  test 'should assign labels and rank scores to cars' do
    service = CarsFilterService.new({ query: 'Toyota' }, @user)

    filtered_cars = service.call

    filtered_cars.each do |car|
      assert_includes %w[perfect_match good_match null], car.label
    end

    filtered_cars.each do |car|
      assert_not_nil car.rank_score
    end
  end

  private

  def stub_car_recommendations_api
    response_body = [
      { "car_id": @sentra.id, "rank_score": 0.945 },
      { "car_id": @versa.id, "rank_score": 0.4552 },
      { "car_id": @camry.id, "rank_score": 0.567 },
      { "car_id": @corolla.id, "rank_score": 0.945 },
      { "car_id": @ls.id, "rank_score": 0.4552 },
      { "car_id": @is.id, "rank_score": 0.567 }
    ].to_json

    WebMock.stub_request(:get, @recommendation_service.base_url)
           .with(query: { user_id: @user.id })
           .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })
  end
end
