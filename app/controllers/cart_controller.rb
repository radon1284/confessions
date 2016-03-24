class CartController < ApplicationController
  def add
    product = Product.find(params.fetch(:product_id))
    AddProductToCart.build.call(product, current_visitor)
    redirect_to cart_url
  end

  def show
    cart = RestoreCart.build.call(current_visitor, Time.current)
    render(
      locals: {
        cart: cart
      }
    )
  end
end
