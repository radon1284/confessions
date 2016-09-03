class PaymentsController < ApplicationController
  def pay
    order = pay_for_cart
    redirect_to completed_order_url(order), notice: t("payment.success")
  rescue MakeStripePayment::PaymentFailedDueToCustomer => ex
    redirect_to cart_url, flash: {
      error: t("payment.failure.customer_error", reason: ex.message)
    }
  rescue MakeStripePayment::PaymentFailedDueToUs
    redirect_to cart_url, flash: { error: t("payment.failure.server_error") }
  end

  private

  def pay_for_cart
    DI.get(PayForCart).call(
      visitor: current_visitor,
      stripe_token: stripe_token,
      email: email_provided_by_stripe,
      ip_address: request.remote_ip,
      subscribed_to_mailing_list: subscribed_to_mailing_list
    )
  end

  def stripe_token
    params.fetch(:stripeToken)
  end

  def email_provided_by_stripe
    params.fetch(:stripeEmail)
  end

  def subscribed_to_mailing_list
    params.fetch(:subscribed_to_mailing_list, false)
  end
end
