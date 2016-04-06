class ProductAddedToCart
  attr_accessor :visitor

  def initialize(visitor, product)
    self.visitor = visitor
    self.product = product
  end

  def payload
    {
      product_id: product.id,
      price_in_cents: product.price_in_cents,
      currency: product.currency
    }
  end

  private

  attr_accessor :product
end
