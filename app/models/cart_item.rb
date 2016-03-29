class CartItem
  include Equalizer.new(:product_id)

  attr_reader :product_id, :price
  attr_accessor :product

  delegate :display_name, to: :product

  def initialize(product_id, price_in_cents, currency)
    self.product_id = Integer(product_id)
    self.price = Money.new(price_in_cents, currency)
  end

  private

  attr_writer :product_id, :price
end
