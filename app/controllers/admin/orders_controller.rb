class Admin::OrdersController < Admin::BaseController
  def index
    orders =
      Order.includes(:user).order(created_at: :desc).page(params[:page])
    render(
      locals: {
        orders: orders
      }
    )
  end
end
