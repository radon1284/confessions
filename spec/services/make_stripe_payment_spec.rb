require "rails_helper"

describe MakeStripePayment, :vcr do
  let!(:service) { MakeStripePayment.build }
  let!(:cart_item) { CartItem.new(1, 1000, "USD") }
  let!(:cart) { Cart.new([cart_item]) }

  context "with valid credit card details" do
    let!(:token) do
      Stripe::Token.create(
        card: {
          number: "4242424242424242",
          exp_month: 7,
          exp_year: 2019,
          cvc: "313"
        }
      )
    end

    it "raises no exception" do
      expect { service.call(cart, token) }.not_to raise_error
    end
  end
end
