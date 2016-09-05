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

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def call(
    visitor:,
    stripe_token:,
    email:,
    ip_address:,
    subscribed_to_mailing_list:
  )
    cart = restore_cart.call(visitor, Time.current)
    order_id = generate_order_id
    stripe_charge_identifier = make_stripe_payment.call(
      cart,
      stripe_token,
      order_id
    )
    user = existing_or_new_user(email, subscribed_to_mailing_list)
    order = user.orders.create!(
      id: order_id,
      order_items: build_order_items(cart),
      invoice_number: generate_invoice_number,
      ip_address: ip_address,
      stripe_charge_identifier: stripe_charge_identifier
    )
    EventPublisher.publish(CartCleared.new(visitor))
    EventPublisher.publish(OrderCompleted.new(visitor, order))

    order
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  private

  attr_accessor :restore_cart
  attr_accessor :make_stripe_payment

  def generate_order_id
    SecureRandom.uuid
  end

  def existing_or_new_user(email, subscribed_to_mailing_list)
    user = User.where(email: email).first_or_initialize
    user.subscribed_to_mailing_list = subscribed_to_mailing_list
    user.save!
    user
  end

  def build_order_items(cart)
    cart.items.map do |cart_item|
      OrderItem.new(
        product_id: cart_item.product_id,
        price_in_cents: cart_item.price.cents,
        currency: cart_item.price.currency
      )
    end
  end

  def generate_invoice_number
    current_month = Time.current.beginning_of_month..Time.current
    ordinal_number = Order.where(created_at: current_month).count + 1
    "BP-#{Time.current.strftime('%Y-%-m')}-#{ordinal_number}"
  end
end
