require "rails_helper"

describe OrderConfirmationMailer do
  describe "confirmation" do
    let!(:order) { FactoryGirl.create(:order) }
    let!(:mail) { OrderConfirmationMailer.confirmation(order) }

    it "includes the link to the order" do
      expect(mail.body.encoded).to match(order.id)
    end
  end
end
