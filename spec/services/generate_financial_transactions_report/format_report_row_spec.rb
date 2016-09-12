require "rails_helper"

describe GenerateFinancialTransactionsReport::FormatReportRow do
  let!(:service) do
    GenerateFinancialTransactionsReport::FormatReportRow.build
  end
  let!(:report_row) do
    GenerateFinancialTransactionsReport::ReportRow.new(
      date: Time.current,
      country_code: "GR",
      amount: 23_000,
      transaction_type_code: 1234,
      sheet_number: 1
    )
  end

  it "returns customized country code for Greece" do
    _, _, _, country_code, = service.call(report_row)
    expect(country_code).to eq "EL"
  end
end
