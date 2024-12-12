class CarsController < ApplicationController
  def index
    unless permitted_params[:user_id].present?
      return render json: { error: 'user_id is required' }, status: :bad_request
    end

    cars = CarsFilterService.new(permitted_params, current_user).call

    render json: cars
  end

  private

  def permitted_params
    params.permit(:user_id, :query, :price_min, :price_max, :page)
  end

  def current_user
    User.find(permitted_params[:user_id])
  end
end
