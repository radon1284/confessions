require "rails_helper"

describe "Payment", :js do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:visitor) { Visitor.new("123") }

  before do
    AddProductToCart.build.call(product, visitor)
    create_cookie("visitor_identifier", "123")
  end

  it "works" do
    visit cart_path
    page.execute_script("$(\"form\").append(\"<input value='token' \
      name='stripeToken'>\").submit()")
    expect(page).to have_content("Thank you for paying!")
  end
end
