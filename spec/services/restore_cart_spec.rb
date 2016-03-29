require "rails_helper"

describe RestoreCart do
  let!(:service) { RestoreCart.build }
  let!(:interesting_book) { FactoryGirl.create(:book, slug: "interesting") }
  let!(:interesting_product) do
    FactoryGirl.create(
      :product,
      price_in_cents: 10_000,
      purchasable: interesting_book
    )
  end
  let!(:long_book) { FactoryGirl.create(:book, slug: "long") }
  let!(:long_product) do
    FactoryGirl.create(
      :product,
      price_in_cents: 5_000,
      purchasable: long_book
    )
  end
  let!(:visitor) { Visitor.new("123") }

  before do
    AddProductToCart.build.call(interesting_product, visitor)
    AddProductToCart.build.call(long_product, visitor)
  end

  it "calculates the cart total" do
    cart = service.call(visitor, Time.current)
    expect(cart.total).to eq Money.new(15_000, "USD")
  end

  it "fetches the cart items" do
    cart = service.call(visitor, Time.current)
    expect(cart.items.size).to eq 2

    expect(cart.items.map(&:price))
      .to contain_exactly(interesting_product.price, long_product.price)
  end

  context "when cart was cleared" do
    before do
      PersistedEvent.create!(
        event_type: "cart_cleared",
        visitor_identifier: visitor.identifier
      )
      AddProductToCart.build.call(long_product, visitor)
    end

    it "returns only the items added after clearing" do
      cart = service.call(visitor, Time.current)
      expect(cart.items.size).to eq 1
    end
  end

  context "when a product was later removed" do
    before do
      RemoveProductFromCart.build.call(interesting_product, visitor)
    end

    it "doesn't return this product" do
      cart = service.call(visitor, Time.current)
      expect(cart.items.size).to eq 1
    end
  end
end
