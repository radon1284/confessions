require "rails_helper"

describe PayForCart do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:cart_item) { CartItem.new(product.id, 1_000, "USD") }
  let!(:cart) { Cart.new([cart_item]) }
  let!(:restore_cart) { ->(_, _) { cart } }
  let!(:make_stripe_payment) { -> (_, _, _) {} }
  let!(:service) { PayForCart.new(restore_cart, make_stripe_payment) }
  let!(:visitor) { Visitor.new("123") }
  let!(:stripe_token) { "abc" }
  let!(:email) { "test@example.com" }

  it "creates a new order" do
    expect {
      service.call(
        visitor: visitor,
        stripe_token: stripe_token,
        email: email,
        ip_address: "8.8.8.8"
      )
    }
      .to change { Order.count }.by(1)
  end

  it "creates order items" do
    service.call(
      visitor: visitor,
      stripe_token: stripe_token,
      email: email,
      ip_address: "8.8.8.8"
    )
    order = Order.last
    expect(order.order_items.count).to eq 1
    expect(order.order_items.last.price_in_cents).to eq 1_000
  end

  it "clears the cart" do
    expect {
      service.call(
        visitor: visitor,
        stripe_token: stripe_token,
        email: email,
        ip_address: "8.8.8.8"
      )
    }.to change { PersistedEvent.where(event_type: "cart_cleared").count }
      .by(1)
  end

  it "publishes the order completed event" do
    expect {
      service.call(
        visitor: visitor,
        stripe_token: stripe_token,
        email: email,
        ip_address: "8.8.8.8"
      )
    }.to change {
      PersistedEvent.where(event_type: "order_completed").count
    }.by(1)
  end

  it "generates invoice number for order" do
    service.call(
      visitor: visitor,
      stripe_token: stripe_token,
      email: email,
      ip_address: "8.8.8.8"
    )
    order = Order.last
    expect(order.invoice_number).to eq(
      "BP-#{Time.current.year}-#{Time.current.month}-1"
    )
  end

  it "stores IP address of the user" do
    service.call(
      visitor: visitor,
      stripe_token: stripe_token,
      email: email,
      ip_address: "8.8.8.8"
    )
    order = Order.last
    expect(order.ip_address).to eq("8.8.8.8")
  end

  describe "assigning order to user" do
    context "when there is no user with given email address" do
      it "creates a new user" do
        expect {
          service.call(
            visitor: visitor,
            stripe_token: stripe_token,
            email: email,
            ip_address: "8.8.8.8"
          )
        }.to change { User.count }
          .by(1)
      end

      it "creates association between order and user" do
        service.call(
          visitor: visitor,
          stripe_token: stripe_token,
          email: email,
          ip_address: "8.8.8.8"
        )
        order = Order.last
        expect(order.user.email).to eq email
      end
    end

    context "when it is a returning customer" do
      let!(:user) { FactoryGirl.create(:user, email: email) }

      it "creates association between order and existing user" do
        service.call(
          visitor: visitor,
          stripe_token: stripe_token,
          email: email,
          ip_address: "8.8.8.8"
        )
        order = Order.last
        expect(order.user).to eq user
      end
    end
  end

  describe "connecting order with Stripe charge" do
    let!(:make_stripe_payment) { spy("make_stripe_payment") }
    let!(:service) { PayForCart.new(restore_cart, make_stripe_payment) }

    it "passes order UUID" do
      service.call(
        visitor: visitor,
        stripe_token: stripe_token,
        email: email,
        ip_address: "8.8.8.8"
      )
      uuid = Order.last.id
      expect(make_stripe_payment)
        .to have_received(:call)
        .with(anything, anything, uuid)
    end
  end
end
