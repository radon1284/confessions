class OrdersController < ApplicationController
  def show
    order = Order.includes(products: :purchasable).find(params.fetch(:id))
    render(
      locals: {
        order: order
      }
    )
  end

  def index
    return redirect_to login_url if current_user.blank?
    orders = current_user.orders
    render(
      locals: {
        orders: orders
      }
    )
  end
end
