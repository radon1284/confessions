require "rails_helper"

describe GenerateFinancialTransactionsReport do
  let!(:order) { FactoryGirl.create(:order, country_from_ip: "GB") }
  let!(:transactions) do
    [
      GenerateFinancialTransactionsReport::Transaction.new(
        "charge",
        2_299,
        Time.zone.parse("2016-09-10 09:34:22"),
        order.id,
        123
      )
    ]
  end
  let!(:get_transactions) do
    ->(_) { transactions }
  end
  let!(:service) do
    GenerateFinancialTransactionsReport.new(
      get_transactions,
      GenerateFinancialTransactionsReport::ProcessTransaction.build,
      GenerateFinancialTransactionsReport::CreateCSV.build
    )
  end

  before do
    VATRateResponse.create!(
      date: Time.zone.parse("2016-09-10"),
      payload: {
        rates: {
          GB: {
            standard_rate: 20
          }
        }
      }
    )
  end

  it "creates new record in the database" do
    expect { service.call("9", "2016") }
      .to change { FinancialTransactionsReport.count }
      .by(1)
  end
end
