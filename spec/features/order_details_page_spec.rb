require "rails_helper"

describe "Order details page" do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) do
    FactoryGirl.create(:order_item, product: product, order: order)
  end

  it "shows the names of purchased products" do
    visit order_path(order)
    expect(page).to have_content(product.display_name)
  end
end
