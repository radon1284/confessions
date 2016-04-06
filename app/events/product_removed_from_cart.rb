class ProductRemovedFromCart
  attr_accessor :visitor

  def initialize(visitor, product)
    self.visitor = visitor
    self.product = product
  end

  def payload
    {
      product_id: product.id
    }
  end

  private

  attr_accessor :product
end
