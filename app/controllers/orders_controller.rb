class OrdersController < ApplicationController
  def show
    order = find_order
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

  def completed
    order = find_order
    render(
      locals: {
        order: order
      }
    )
  end

  private

  def find_order
    Order
      .includes(:books, watermarked_books: :book)
      .find(params.fetch(:id))
  end
end
