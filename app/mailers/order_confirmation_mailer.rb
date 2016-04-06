class OrderConfirmationMailer < ApplicationMailer
  def confirmation(order)
    @order = order
    mail to: order.user.email
  end
end
