require "rails_helper"

describe GenerateFinancialTransactionsReport::CalculateVATKey do
  let!(:service) do
    GenerateFinancialTransactionsReport::CalculateVATKey.build
  end

  context "for a country in the EU but not Germany" do
    it "returns 44" do
      result = service.call("FR")
      expect(result).to eq 44
    end
  end

  context "for Germany" do
    it "returns nil" do
      result = service.call("DE")
      expect(result).to eq nil
    end
  end
end
