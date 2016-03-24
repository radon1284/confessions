require "rails_helper"

describe "Visitor identification" do
  context "when a visitor enters the site for the first time" do
    it "gives him a unique identifier" do
      visit root_path
      cookie = get_me_the_cookie("visitor_identifier")
      expect(cookie).to be_present
    end
  end

  context "when a visitor enters the site for the second time" do
    it "uses the same identifier" do
      visit root_path
      first_cookie = get_me_the_cookie("visitor_identifier")
      visit root_path
      second_cookie = get_me_the_cookie("visitor_identifier")
      expect(second_cookie[:value]).to eq first_cookie[:value]
    end
  end
end
