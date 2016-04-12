class CustomerSupportNotificationMailer < ApplicationMailer
  def notification(customer_support_request)
    @customer_support_request = customer_support_request
    mail(
      to: ENV.fetch("CUSTOMER_SUPPORT_INBOX"),
      reply_to: customer_support_request.email,
      subject: "New customer support request"
    )
  end
end
