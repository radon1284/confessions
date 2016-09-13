require "rails_helper"

describe "Access previous orders" do
  context "when user is not logged in" do
    it "redirects to login page" do
      visit orders_path
      expect(page).to have_content("Please login")
    end
  end

  context "when user is logged in" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:first_order) do
      FactoryGirl.create(
        :order,
        user: user,
        created_at: Time.zone.local(2016, 3, 20)
      )
    end
    let!(:second_order) do
      FactoryGirl.create(
        :order,
        user: user,
        created_at: Time.zone.local(2016, 2, 12)
      )
    end

    before do
      sign_in(user)
    end

    it "shows the list of previous orders" do
      visit orders_path
      expect(page).to have_content("Order 2016-03-20")
      expect(page).to have_content("Order 2016-02-12")
    end
  end
end
