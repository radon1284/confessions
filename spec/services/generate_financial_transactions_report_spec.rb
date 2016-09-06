require "rails_helper"

describe GenerateFinancialTransactionsReport do
  let!(:service) { GenerateFinancialTransactionsReport.build }

  it "creates new record in the database" do
    expect { service.call("8", "2016") }
      .to change { FinancialTransactionsReport.count }
      .by(1)
  end
end
