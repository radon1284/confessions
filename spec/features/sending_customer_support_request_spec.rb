require "rails_helper"

describe "Sending customer support request" do
  it "saves the request in the database" do
    visit new_customer_support_request_path
    fill_in "Subject", with: "I have a problem"
    fill_in "Message", with: "Don't know what to do"
    fill_in "Email", with: "customer@example.com"
    expect { click_on "Send" }
      .to change { CustomerSupportRequest.count }
      .by(1)
  end
end
