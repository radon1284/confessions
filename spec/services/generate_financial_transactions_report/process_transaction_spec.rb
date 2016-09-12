require "rails_helper"

describe GenerateFinancialTransactionsReport::ProcessTransaction do
  let!(:service) do
    GenerateFinancialTransactionsReport::ProcessTransaction.build
  end

  describe "transfer" do
    let!(:transaction) do
      GenerateFinancialTransactionsReport::Transaction.new(
        "transfer",
        -10_000,
        3.days.ago,
        nil,
        0
      )
    end

    it "returns one row going to the third sheet" do
      rows = service.call(transaction)
      expect(rows.size).to eq 1
      expect(rows.first.sheet_number).to eq 3
    end
  end

  describe "refund" do
    let!(:order) { FactoryGirl.create(:order, country_from_stripe: "DE") }
    let!(:transaction) do
      GenerateFinancialTransactionsReport::Transaction.new(
        "refund",
        -2_000,
        Time.zone.parse("2016-09-05 14:45:21"),
        order.id,
        -100
      )
    end

    before do
      VATRateResponse.create!(
        date: Time.zone.parse("2016-09-05"),
        payload: {
          rates: {
            DE: {
              standard_rate: 19
            }
          }
        }
      )
    end

    it "returns refunded charge and refunded fee" do
      rows = service.call(transaction)
      expect(rows.size).to eq 2
    end
  end
end
