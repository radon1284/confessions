class PaymentsController < ApplicationController
  def pay
    stripe_token = params.fetch(:stripeToken)
    DI.get(PayForCart).call(current_visitor, stripe_token)
    redirect_to root_url, notice: "Thank you for paying!"
  end
end
