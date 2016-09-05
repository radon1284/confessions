class StripeCountryWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    DI.get(FetchCountryFromStripe).call(order)
  end
end
