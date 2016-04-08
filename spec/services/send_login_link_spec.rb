require "rails_helper"

describe SendLoginLink do
  let!(:service) { SendLoginLink.build }
  let!(:user) { FactoryGirl.create(:user) }

  it "sends an email" do
    service.call(user)
    expect(last_email).to be_present
  end
end
