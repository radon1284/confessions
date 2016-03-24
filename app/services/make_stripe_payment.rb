class MakeStripePayment
  class PaymentFailed < RuntimeError; end

  def self.build
    new
  end

  def call(cart, token)
    Stripe::Charge.create(
      amount: cart.total.cents,
      currency: cart.total.currency,
      source: token
    )
  rescue Stripe::CardError
    raise PaymentFailed
  rescue Stripe::StripeError
    raise PaymentFailed
  end
end
