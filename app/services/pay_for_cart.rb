class PayForCart
  def self.build
    new(
      DI.get(RestoreCart),
      DI.get(MakeStripePayment)
    )
  end

  def initialize(restore_cart, make_stripe_payment)
    self.restore_cart = restore_cart
    self.make_stripe_payment = make_stripe_payment
  end

  def call(visitor, stripe_token)
    cart = restore_cart.call(visitor, Time.current)
    make_stripe_payment.call(cart, stripe_token)
    Order.create!(order_items: build_order_items(cart))
  end

  private

  attr_accessor :restore_cart
  attr_accessor :make_stripe_payment

  def build_order_items(cart)
    cart.items.map do |cart_item|
      OrderItem.new(
        product_id: cart_item.product_id,
        price_in_cents: cart_item.price.cents,
        currency: cart_item.price.currency
      )
    end
  end
end
