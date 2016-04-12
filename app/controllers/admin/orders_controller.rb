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

  def show
    order = Order.includes(products: :purchasable).find(params.fetch(:id))
    render(
      locals: {
        order: order
      }
    )
  end
end
