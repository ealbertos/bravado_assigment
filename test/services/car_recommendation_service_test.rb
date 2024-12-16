require 'test_helper'

class CarRecommendationServiceTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @service = CarRecommendationService.new
  end

  test 'should return car recommendations for the user' do
    response_body = [
      { "car_id": 179, "rank_score": 0.945 },
      { "car_id": 5, "rank_score": 0.4552 },
      { "car_id": 13, "rank_score": 0.567 }
    ].to_json

    stub_request(:get, @service.base_url)
      .with(query: { user_id: @user.id })
      .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

    response = @service.car_recommendations(@user)
    recommendations = JSON.parse(response.body)

    assert_equal 3, recommendations.size
    assert_equal 179, recommendations.first['car_id']
    assert_equal 0.945, recommendations.first['rank_score']
    assert_equal 5, recommendations.second['car_id']
    assert_equal 0.4552, recommendations.second['rank_score']
    assert_equal 13, recommendations.third['car_id']
    assert_equal 0.567, recommendations.third['rank_score']
  end
end
