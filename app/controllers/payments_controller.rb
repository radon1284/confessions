class PaymentsController < ApplicationController
  def pay
    DI.get(PayForCart).call(current_visitor, stripe_token)
    redirect_to root_url, notice: t("payment.success")
  rescue MakeStripePayment::PaymentFailedDueToCustomer => ex
    redirect_to cart_url, flash: {
      error: t("payment.failure.customer_error", reason: ex.message)
    }
  rescue MakeStripePayment::PaymentFailedDueToUs
    redirect_to cart_url, flash: { error: t("payment.failure.server_error") }
  end

  private

  def stripe_token
    params.fetch(:stripeToken)
  end
end
