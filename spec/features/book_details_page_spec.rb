require "rails_helper"

describe "Book details page" do
  let!(:book) { FactoryGirl.create(:book) }
  let!(:product) do
    FactoryGirl.create(
      :product,
      price_in_cents: 1599,
      currency: "USD",
      purchasable: book
    )
  end

  it "contains the book title" do
    visit book_path(book.slug)
    expect(page).to have_content(book.title.scan(/\w+/).first)
  end
end
