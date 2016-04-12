require "rails_helper"

describe "View all orders" do
  let!(:customer) { FactoryGirl.create(:user) }
  let!(:order) { FactoryGirl.create(:order, user: customer) }

  before do
    sign_in_admin
  end

  it "shows the list of orders" do
    visit admin_orders_path
    expect(page).to have_content(customer.email)
  end
end
