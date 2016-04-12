require "rails_helper"

describe "Sending customer support request" do
  def fill_in_the_form
    fill_in "Subject", with: "I have a problem"
    fill_in "Message", with: "Don't know what to do"
    fill_in "Email", with: "customer@example.com"
  end

  it "saves the request in the database" do
    visit new_customer_support_request_path
    fill_in_the_form
    expect { click_on "Send" }
      .to change { CustomerSupportRequest.count }
      .by(1)
  end

  it "sends an email to the customer support inbox" do
    visit new_customer_support_request_path
    fill_in_the_form
    expect { click_on "Send" }
      .to change { CustomerSupportNotificationWorker.jobs.size }
      .by(1)
  end
end
