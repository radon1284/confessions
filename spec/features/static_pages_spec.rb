require "rails_helper"

describe "Static pages" do
  describe "impressum" do
    it "exists" do
      visit impressum_path
      expect(page).to have_content("Impressum")
    end
  end

  describe "privacy policy" do
    it "exists" do
      visit privacy_policy_path
      expect(page).to have_content("Privacy policy")
    end
  end

  describe "terms and conditions" do
    it "exists" do
      visit terms_path
      expect(page).to have_content("Terms and conditions")
    end
  end
end
