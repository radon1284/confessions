require "rails_helper"

describe "Payment", :js do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:visitor) { Visitor.new("123") }
  let!(:make_stripe_payment) { ->(_, _, _) { "charge_identifier" } }

  before do
    EventPublisher.publish(ProductAddedToCart.new(visitor, product))
    pretend_to_be_visitor(visitor)
    DI.add_override(MakeStripePayment, make_stripe_payment)
  end

  def simulate_user_filling_in_the_form
    page.execute_script("$(\"form#test-stripe-payment\") \
      .append(\"<input value='token' \
      name='stripeToken'><input value='test@example.com' \
      name='stripeEmail'>\").submit()")
  end

  it "shows message after successful payment" do
    visit cart_path
    simulate_user_filling_in_the_form
    expect(page).to have_content("Thank you for paying!")
  end

  it "redirects to the special order completed page" do
    visit cart_path
    simulate_user_filling_in_the_form
    expect(page).to have_content("YOUR ORDER DETAILS")
    expect(current_path).to include("/orders/order_completed/")
  end

  it "subscribes user to the mailing list by default" do
    visit cart_path
    simulate_user_filling_in_the_form
    expect(page).to have_content("Thank you for paying!")
    expect(User.last.subscribed_to_mailing_list).to eq true
  end
end
