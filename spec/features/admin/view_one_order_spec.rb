require "rails_helper"

describe "View one order" do
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) do
    FactoryGirl.create(
      :order_item,
      order: order,
      price_in_cents: 10_000
    )
  end

  before do
    sign_in_admin
  end

  it "shows the total of the order" do
    visit admin_order_path(order)
    expect(page).to have_content("$100")
  end
end
