class OrderConfirmationWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    OrderConfirmationMailer.confirmation(order).deliver_now
  end
end
