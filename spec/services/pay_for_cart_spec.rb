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
  let!(:email) { "test@example.com" }

  it "creates a new order" do
    expect { service.call(visitor, stripe_token, email) }
      .to change { Order.count }.by(1)
  end

  it "creates order items" do
    service.call(visitor, stripe_token, email)
    order = Order.last
    expect(order.order_items.count).to eq 1
    expect(order.order_items.last.price_in_cents).to eq 1_000
  end

  it "clears the cart" do
    expect { service.call(visitor, stripe_token, email) }
      .to change { PersistedEvent.where(event_type: "cart_cleared").count }
      .by(1)
  end

  describe "assigning order to user" do
    context "when there is no user with given email address" do
      it "creates a new user" do
        expect { service.call(visitor, stripe_token, email) }
          .to change { User.count }
          .by(1)
      end

      it "creates association between order and user" do
        service.call(visitor, stripe_token, email)
        order = Order.last
        expect(order.user.email).to eq email
      end
    end

    context "when it is a returning customer" do
      let!(:user) { FactoryGirl.create(:user, email: email) }

      it "creates association between order and existing user" do
        service.call(visitor, stripe_token, email)
        order = Order.last
        expect(order.user).to eq user
      end
    end
  end
end
