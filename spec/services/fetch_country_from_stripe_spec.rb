require "rails_helper"

describe FetchCountryFromStripe, :vcr do
  let!(:service) { FetchCountryFromStripe.build }
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
  let!(:charge) do
    Stripe::Charge.create(
      amount: 100,
      currency: "USD",
      source: token.id,
      metadata: { order_id: "dummy" }
    )
  end
  let!(:order) do
    FactoryGirl.create(:order, stripe_charge_identifier: charge.id)
  end

  it "saves the credit card country to order" do
    expect { service.call(order) }
      .to change { order.reload.country_from_stripe }
      .from(nil)
      .to("US")
  end
end
