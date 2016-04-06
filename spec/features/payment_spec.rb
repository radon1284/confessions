require "rails_helper"

describe "Payment", :js do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:visitor) { Visitor.new("123") }
  let!(:make_stripe_payment) { ->(_, _, _) {} }

  before do
    EventPublisher.publish(ProductAddedToCart.new(visitor, product))
    pretend_to_be_visitor(visitor)
    DI.add_override(MakeStripePayment, make_stripe_payment)
  end

  def simulate_user_filling_in_the_form
    page.execute_script("$(\"form\").append(\"<input value='token' \
      name='stripeToken'><input value='test@example.com' \
      name='stripeEmail'>\").submit()")
  end

  it "shows message after successful payment" do
    visit cart_path
    simulate_user_filling_in_the_form
    expect(page).to have_content("Thank you for paying!")
  end

  it "redirects to the order page" do
    visit cart_path
    simulate_user_filling_in_the_form
    expect(page).to have_content("Your order details")
  end
end
