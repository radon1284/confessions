require "rails_helper"

describe PayForCart do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:cart_item) { CartItem.new(product.id, 1_000, "USD") }
  let!(:cart) { Cart.new([cart_item]) }
  let!(:restore_cart) { ->(_, _) { cart } }
  let!(:make_stripe_payment) { -> (_, _) {} }
  let!(:service) { PayForCart.new(restore_cart, make_stripe_payment) }
  let!(:visitor) { Visitor.new("123") }
  let!(:stripe_token) { "abc" }

  it "creates a new order" do
    expect { service.call(visitor, stripe_token) }
      .to change { Order.count }.by(1)
  end

  it "creates order items" do
    service.call(visitor, stripe_token)
    order = Order.last
    expect(order.order_items.count).to eq 1
    expect(order.order_items.last.price_in_cents).to eq 1_000
  end
end
