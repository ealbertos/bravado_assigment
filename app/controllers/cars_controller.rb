class CarsController < ApplicationController
  def index
    unless permitted_params[:user_id].present?
      return render json: { error: 'user_id is required' }, status: :bad_request
    end

    cars = CarsFilterService.new(permitted_params, current_user).call
    cars = Kaminari.paginate_array(cars).page(params[:page] || 1).per(20)

    render json: cars, each_serializer: CarSerializer, meta: pagination_meta(cars)
  end

  private

  def permitted_params
    params.permit(:user_id, :query, :price_min, :price_max, :page)
  end

  def current_user
    User.find(permitted_params[:user_id])
  end

  def pagination_meta(cars)
    {
      current_page: cars.current_page,
      next_page: cars.next_page,
      prev_page: cars.prev_page,
      total_pages: cars.total_pages,
      total_count: cars.total_count
    }
  end
end
