class RestoreCart
  RELEVANT_EVENT_TYPES = %w(product_added_to_cart cart_cleared).freeze

  def self.build
    new
  end

  def call(visitor, time)
    events = fetch_events(visitor, time)
    cart_items = apply_events(events)
    fetch_products_for_items(cart_items)
    Cart.new(cart_items)
  end

  private

  def fetch_events(visitor, time)
    PersistedEvent
      .where(visitor_identifier: visitor.identifier)
      .where(event_type: RELEVANT_EVENT_TYPES)
      .where("created_at < ?", time)
      .order(:created_at)
      .limit(100)
  end

  def apply_events(events)
    events
      .reduce(Set.new) do |state, event|
        case event.event_type
        when "product_added_to_cart"
          state.add(cart_item_from_event(event))
        when "cart_cleared"
          state.clear
        end
      end
      .to_a
  end

  def fetch_products_for_items(cart_items)
    products =
      Product
      .includes(:purchasable)
      .find(cart_items.map(&:product_id))

    cart_items.each do |cart_item|
      cart_item.product = products.find do |product|
        product.id == cart_item.product_id
      end
    end
  end

  def cart_item_from_event(event)
    CartItem.new(
      event.payload.fetch("product_id"),
      event.payload.fetch("price_in_cents"),
      event.payload.fetch("currency")
    )
  end
end
