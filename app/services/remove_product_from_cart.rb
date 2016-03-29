class RemoveProductFromCart
  def self.build
    new
  end

  def call(product, visitor)
    PersistedEvent.create!(
      event_type: "product_removed_from_cart",
      visitor_identifier: visitor.identifier,
      payload: {
        product_id: product.id
      }
    )
  end
end
