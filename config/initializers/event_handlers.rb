require Rails.root.join("lib", "event_publisher")

EventPublisher.push_handler(
  CartCleared,
  ->(event) { DI.get(PersistEvent).call(event) }
)
EventPublisher.push_handler(
  ProductAddedToCart,
  ->(event) { DI.get(PersistEvent).call(event) }
)
EventPublisher.push_handler(
  ProductRemovedFromCart,
  ->(event) { DI.get(PersistEvent).call(event) }
)
EventPublisher.push_handler(
  OrderCompleted,
  ->(event) { DI.get(PersistEvent).call(event) }
)
EventPublisher.push_handler(
  OrderCompleted,
  ->(event) { OrderConfirmationWorker.perform_async(event.order.id) }
)
