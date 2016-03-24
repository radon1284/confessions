require "rails_helper"

describe AddProductToCart do
  let!(:service) { AddProductToCart.build }
  let!(:product) { FactoryGirl.create(:product) }
  let!(:visitor) { Visitor.new("123") }

  it "stores a new event" do
    expect { service.call(product, visitor) }
      .to change { PersistedEvent.count }.by(1)
  end

  it "stores product id and price" do
    service.call(product, visitor)
    event = PersistedEvent.last
    expect(event.payload["product_id"]).to eq product.id
    expect(event.payload["price_in_cents"]).to eq product.price_in_cents
  end
end
