class CartController < ApplicationController
  def add
    product = Product.find(params.fetch(:product_id))
    EventPublisher.publish(
      ProductAddedToCart.new(current_visitor, product)
    )
    redirect_to cart_url
  end

  def show
    cart = DI.get(RestoreCart).call(current_visitor, Time.current)
    render(
      locals: {
        cart: cart
      }
    )
  end

  def remove
    product = Product.find(params.fetch(:product_id))
    EventPublisher.publish(
      ProductRemovedFromCart.new(current_visitor, product)
    )
    redirect_to cart_url
  end
end
