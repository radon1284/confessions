require "rails_helper"

describe GenerateFinancialTransactionsReport::GetTransactions do
  let!(:transfer) do
    OpenStruct.new(
      type: "transfer",
      amount: -12_345,
      fee: 0,
      created: 1_473_465_600
    )
  end
  let!(:refund) do
    OpenStruct.new(
      type: "refund",
      amount: -1_000,
      fee: -200,
      created: 1_473_251_066,
      source: OpenStruct.new(
        charge: OpenStruct.new(
          metadata: OpenStruct.new(
            order_id: "123"
          )
        )
      )
    )
  end
  let!(:charge) do
    OpenStruct.new(
      type: "charge",
      amount: 2_000,
      fee: 300,
      created: 1_473_079_039,
      source: OpenStruct.new(
        metadata: OpenStruct.new(
          order_id: "456"
        )
      )
    )
  end
  let!(:transactions) { [transfer, refund, charge] }
  let!(:fetch_from_stripe) { ->(_, _) { transactions } }
  let!(:service) do
    GenerateFinancialTransactionsReport::GetTransactions.new(fetch_from_stripe)
  end

  it "gets the data relevant for us" do
    result = service.call(Time.current)
    expect(result.size).to eq 3

    expect(result[0].amount).to eq(-12_345)
    expect(result[0].date).to eq Time.zone.parse("2016-09-10")

    expect(result[1].type).to eq "refund"
    expect(result[1].order_id).to eq "123"

    expect(result[2].fee_amount).to eq 300
    expect(result[2].order_id). to eq "456"
  end
end
