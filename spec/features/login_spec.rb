require "rails_helper"

describe "Login" do
  let!(:user) { FactoryGirl.create(:user) }

  describe "asking to log in" do
    it "schedules a job to send a login link" do
      visit login_path
      fill_in :email, with: user.email
      click_on "Send"
      expect(page).to have_content(
        "We have sent the login link to the specified email address."
      )
      expect(LoginLinkWorker.jobs.size).to eq 1
    end
  end

  describe "using the login link" do
    let!(:login_token) do
      SecureToken.encode(
        { user_id: user.id },
        "login_link",
        24.hours.from_now
      )
    end

    it "logs in the user" do
      visit authentication_authenticate_by_token_path(token: login_token)
      expect(page).to have_content("You have logged in.")
    end
  end
end
