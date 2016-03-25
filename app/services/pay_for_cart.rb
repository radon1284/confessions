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
  end

  private

  attr_accessor :restore_cart
  attr_accessor :make_stripe_payment
end
