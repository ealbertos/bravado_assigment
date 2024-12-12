class CarsFilterService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    cars = Car.all
    cars = filter_by_brand(cars)
    filter_by_price(cars)
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
end
