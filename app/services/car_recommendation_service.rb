class CarRecommendationService < HttpClient
  def base_url
    'https://bravado-images-production.s3.amazonaws.com/recomended_cars.json'
  end

  def headers
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  def car_recommendations(user)
    get(params: { user_id: user.id }, url: base_url)
  end
end
