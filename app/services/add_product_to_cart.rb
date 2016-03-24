class AddProductToCart
  def self.build
    new
  end

  def call(product, visitor)
    PersistedEvent.create!(
      event_type: "product_added_to_cart",
      visitor_identifier: visitor.identifier,
      payload: {
        product_id: product.id,
        price_in_cents: product.price_in_cents,
        currency: product.currency
      }
    )
  end
end
