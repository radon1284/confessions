class CustomerSupportNotificationWorker
  include Sidekiq::Worker

  def perform(customer_support_request_id)
    customer_support_request = CustomerSupportRequest.find(
      customer_support_request_id
    )
    CustomerSupportNotificationMailer.notification(
      customer_support_request
    ).deliver_now
  end
end
