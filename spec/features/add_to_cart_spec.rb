require "rails_helper"

describe "Add to cart" do
  let!(:book) { FactoryGirl.create(:book) }
  let!(:product) { FactoryGirl.create(:product, purchasable: book) }

  it "redirects to the cart page" do
    visit book_path(book.slug)
    first(:button, "add-to-cart-button").click
    expect(current_path).to eq cart_path
  end

  it "shows the product in cart" do
    visit book_path(book.slug)
    first(:button, "add-to-cart-button").click
    expect(page).to have_content(book.title)
    expect(page).to have_content(product.price)
  end
end
