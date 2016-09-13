require "rails_helper"

describe GenerateFinancialTransactionsReport::CalculateTaxRate do
  let!(:service) do
    GenerateFinancialTransactionsReport::CalculateTaxRate.build
  end

  context "for a country outside the EU" do
    it "returns nil" do
      result = service.call(
        "CA",
        DateTime.new(2016, 9, 5, 16, 30)
      )
      expect(result).to eq nil
    end
  end

  context "for a country in the EU" do
    before do
      VATRateResponse.create!(
        date: DateTime.new(2016, 9, 5),
        payload: {
          rates: {
            PT: {
              standard_rate: 23
            }
          }
        }
      )
    end

    it "returns the tax rate" do
      result = service.call(
        "PT",
        DateTime.new(2016, 9, 5, 16, 30)
      )
      expect(result).to eq 23
    end
  end

  context "for a country in the EU with reduced rate for e-books" do
    before do
      VATRateResponse.create!(
        date: DateTime.new(2016, 9, 5),
        payload: {
          rates: {
            FR: {
              standard_rate: 20,
              reduced_rates: {
                "e-books" => 5.5
              }
            }
          }
        }
      )
    end

    it "returns the reduced rate" do
      result = service.call(
        "FR",
        DateTime.new(2016, 9, 5, 16, 30)
      )
      expect(result).to eq 5.5
    end
  end
end
