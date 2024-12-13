class CarMatchLabeler
  def initialize(user, car)
    @user = user
    @car = car
  end

  def match_and_label
    if @user.preferred_brands.include?(@car.brand) && @user.preferred_price_range.include?(@car.price)
      'perfect_match'
    elsif @user.preferred_brands.include?(@car.brand)
      'good_match'
    else
      'null'
    end
  end
end
