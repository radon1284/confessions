class PaymentsController < ApplicationController
  def pay
    cart = DI.get(RestoreCart).call(current_visitor, Time.current)
    stripe_token = params.fetch(:stripeToken)
    DI.get(MakeStripePayment).call(cart, stripe_token)
    redirect_to root_url
  end
end
