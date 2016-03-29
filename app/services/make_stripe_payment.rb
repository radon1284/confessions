class MakeStripePayment
  class PaymentFailedDueToCustomer < RuntimeError; end
  class PaymentFailedDueToUs < RuntimeError; end

  def self.build
    new
  end

  def call(cart, token)
    create_charge(cart.total, token)
  rescue Stripe::CardError => ex
    Rollbar.warning(ex)
    raise PaymentFailedDueToCustomer, ex.message
  rescue Stripe::StripeError => ex
    Rollbar.error(ex)
    raise PaymentFailedDueToUs
  end

  private

  def create_charge(total, token)
    Stripe::Charge.create(
      amount: total.cents,
      currency: total.currency,
      source: token
    )
  end
end