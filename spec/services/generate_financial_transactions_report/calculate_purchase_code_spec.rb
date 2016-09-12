require "rails_helper"

describe GenerateFinancialTransactionsReport::CalculatePurchaseCode do
  let!(:service) do
    GenerateFinancialTransactionsReport::CalculatePurchaseCode.build
  end

  context "for a country in the EU but not Germany" do
    it "returns EU_PURCHASE_CODE" do
      result = service.call("PL")
      expect(result).to eq(
        GenerateFinancialTransactionsReport::EU_PURCHASE_CODE
      )
    end
  end
end
