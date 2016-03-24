require "rails_helper"

describe "Book details page" do
  let!(:book) { FactoryGirl.create(:book, slug: "cto", title: "CTO") }
  let!(:product) do
    FactoryGirl.create(
      :product,
      price_in_cents: 1599,
      currency: "USD",
      purchasable: book
    )
  end

  it "contains the book title" do
    visit book_path("cto")
    expect(page).to have_content("CTO")
  end

  it "shows the price of the product" do
    visit book_path("cto")
    expect(page).to have_content("$15.99")
  end
end
