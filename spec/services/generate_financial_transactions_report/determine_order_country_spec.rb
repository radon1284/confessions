require "rails_helper"

describe GenerateFinancialTransactionsReport::DetermineOrderCountry do
  let!(:service) do
    GenerateFinancialTransactionsReport::DetermineOrderCountry.build
  end

  context "when a customer made invoice requests" do
    let!(:order) do
      FactoryGirl.create(
        :order,
        country_from_stripe: "DE",
        country_from_ip: "ES"
      )
    end
    let!(:older_request) do
      FactoryGirl.create(
        :invoice_request,
        order: order,
        country: "Poland",
        created_at: 2.days.ago
      )
    end
    let!(:newer_request) do
      FactoryGirl.create(
        :invoice_request,
        order: order,
        country: "Italy",
        created_at: 1.day.ago
      )
    end

    it "takes country from the latest invoice request" do
      result = service.call(order)
      expect(result).to eq "IT"
    end
  end

  context "when there are no invoice requests" do
    let!(:order) do
      FactoryGirl.create(
        :order,
        country_from_stripe: "DE",
        country_from_ip: "ES"
      )
    end

    it "takes country from Stripe" do
      result = service.call(order)
      expect(result).to eq "DE"
    end
  end

  context "when there are no invoice requests and no Stripe country" do
    let!(:order) do
      FactoryGirl.create(
        :order,
        country_from_stripe: nil,
        country_from_ip: "ES"
      )
    end

    it "takes country from IP" do
      result = service.call(order)
      expect(result).to eq "ES"
    end
  end
end
