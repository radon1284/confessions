class RestoreCart
  def self.build
    new
  end

  def call(visitor, time)
    cart_items = get_cart_items(visitor, time)
    fetch_products_for_items(cart_items)
    Cart.new(cart_items)
  end

  private

  def get_cart_items(visitor, time)
    PersistedEvent
      .where(visitor_identifier: visitor.identifier)
      .where(event_type: "product_added_to_cart")
      .where("created_at < ?", time).map do |event|
        CartItem.new(
          event.payload.fetch("product_id"),
          event.payload.fetch("price_in_cents"),
          event.payload.fetch("currency")
        )
      end
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
end
