class CartController < ApplicationController
  def add
    product = Product.find(params.fetch(:product_id))
    DI.get(AddProductToCart).call(product, current_visitor)
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
    DI.get(RemoveProductFromCart).call(product, current_visitor)
    redirect_to cart_url
  end
end
