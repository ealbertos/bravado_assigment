class CarsFilterService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    cars = Car.all
    cars = filter_by_brand(cars)
    cars = filter_by_price(cars)
    cars = assign_labels_and_scores(cars)
    sort_cars(cars)
  end

  private

  def filter_by_brand(cars)
    return cars unless @params[:query].present?

    cars.by_brand_name(@params[:query])
  end

  def filter_by_price(cars)
    if @params[:price_min].present? && @params[:price_max].present?
      cars.by_price_range(@params[:price_min], @params[:price_max])
    elsif @params[:price_min].present?
      cars.where('price >= ?', @params[:price_min])
    elsif @params[:price_max].present?
      cars.where('price <= ?', @params[:price_max])
    else
      cars
    end
  end

  def assign_labels_and_scores(cars)
    rank_scores = fetch_rank_scores

    cars.each do |car|
      car.label = CarMatchLabeler.new(@user, car).match_and_label
      car.rank_score = rank_scores[car.id] || nil
    end

    cars
  end

  def fetch_rank_scores
    response = CarRecomendationService.new.car_recomendations(@user)
    car_recomendations = JSON.parse(response.body)

    car_recomendations.each_with_object({}) do |item, hash|
      hash[item['car_id']] = item['rank_score']
    end
  end

  def sort_cars(cars)
    cars.sort_by do |car|
      [
        label_priority(car.label),
        -car.rank_score.to_f,
        car.price
      ]
    end
  end

  def label_priority(label)
    case label
    when 'perfect_match'
      0
    when 'good_match'
      1
    else
      2
    end
  end
end
