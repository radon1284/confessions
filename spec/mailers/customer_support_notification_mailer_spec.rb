require "rails_helper"

describe CustomerSupportNotificationMailer do
  describe "notification" do
    let!(:customer_support_request) do
      FactoryGirl.create(
        :customer_support_request,
        body: "I need help",
        email: "customer@example.com"
      )
    end
    let!(:mail) do
      CustomerSupportNotificationMailer.notification(customer_support_request)
    end

    it "includes the message from the customer" do
      expect(mail.body.encoded).to match("I need help")
    end

    it "is sent to the customer support inbox" do
      expect(mail.to).to eq [ENV.fetch("CUSTOMER_SUPPORT_INBOX")]
    end

    specify "reply to is set to the customer email" do
      expect(mail.reply_to).to eq ["customer@example.com"]
    end
  end
end
