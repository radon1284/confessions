class OrderPostProcessingWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    DI.get(PostProcessOrder).call(order)
  end
end
