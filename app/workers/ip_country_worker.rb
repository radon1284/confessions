class IPCountryWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    DI.get(FetchCountryFromIP).call(order)
  end
end
