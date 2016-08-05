require "rails_helper"

describe "Remove from cart" do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:visitor) { Visitor.new("123") }

  before do
    EventPublisher.publish(ProductAddedToCart.new(visitor, product))
    pretend_to_be_visitor(visitor)
  end

  it "no longer displays product in cart" do
    visit cart_path
    expect(page).to have_content(product.display_name)
    click_on("remove")
    expect(current_path).to eq "/cart"
    expect(page).to have_no_content(product.display_name)
  end
end
