require "rails_helper"

# We cannot test too much stuff here, because the test depends on balance
# transactions which already are in our Stripe account. This means that
# we do not have control over the test environment.

describe GenerateFinancialTransactionsReport::FetchFromStripe, :vcr do
  let!(:service) do
    GenerateFinancialTransactionsReport::FetchFromStripe.build
  end

  it "returns all balance transactions in the given period" do
    result = service.call(
      Time.zone.local(2016, 9, 1),
      Time.zone.local(2016, 9, 30).end_of_day
    )
    expect(result).to be_present
  end
end
