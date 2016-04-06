class PayForCart
  def self.build
    new(
      DI.get(RestoreCart),
      DI.get(MakeStripePayment)
    )
  end

  def initialize(restore_cart, make_stripe_payment)
    self.restore_cart = restore_cart
    self.make_stripe_payment = make_stripe_payment
  end

  def call(visitor, stripe_token, email)
    self.cart = restore_cart.call(visitor, Time.current)
    self.order_id = generate_order_id
    make_stripe_payment.call(cart, stripe_token, order_id)
    handle_successful_payment(visitor, email)
    order
  end

  private

  attr_accessor :restore_cart
  attr_accessor :make_stripe_payment
  attr_accessor :cart
  attr_accessor :order_id
  attr_accessor :order

  def generate_order_id
    SecureRandom.uuid
  end

  def handle_successful_payment(visitor, email)
    user = User.where(email: email).first_or_create!
    self.order = create_order(user)
    EventPublisher.publish(CartCleared.new(visitor))
    EventPublisher.publish(OrderCompleted.new(visitor, order))
  end

  def create_order(user)
    user.orders.create!(
      id: order_id,
      order_items: build_order_items
    )
  end

  def build_order_items
    cart.items.map do |cart_item|
      OrderItem.new(
        product_id: cart_item.product_id,
        price_in_cents: cart_item.price.cents,
        currency: cart_item.price.currency
      )
    end
  end
end
