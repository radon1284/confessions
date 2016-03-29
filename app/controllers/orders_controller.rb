class OrdersController < ApplicationController
  def show
    order = Order.includes(products: :purchasable).find(params.fetch(:id))
    render(
      locals: {
        order: order
      }
    )
  end
end
