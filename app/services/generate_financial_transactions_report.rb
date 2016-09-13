class GenerateFinancialTransactionsReport
  STRIPE_FEE_CODE = 4971
  WITHDRAWAL_CODE = 1360
  GERMANY_PURCHASE_CODE = 8400
  EU_PURCHASE_CODE = 8331
  OUTSIDE_EU_PURCHASE_CODE = 8338
  STRIPE_COUNTER_CODE = 1220

  def self.build
    new(
      DI.get(GetTransactions),
      DI.get(ProcessTransaction),
      DI.get(CreateCSV)
    )
  end

  def initialize(get_transactions, process_transaction, create_csv)
    self.get_transactions = get_transactions
    self.process_transaction = process_transaction
    self.create_csv = create_csv
  end

  def call(month, year)
    date = get_date(month, year)
    transactions = get_transactions.call(date)
    report_rows_by_sheet = process_and_group(transactions)

    FinancialTransactionsReport.create!(
      name: "#{year}-#{month}",
      first_sheet: create_csv.call(report_rows_by_sheet.fetch(1, [])),
      second_sheet: create_csv.call(report_rows_by_sheet.fetch(2, [])),
      third_sheet: create_csv.call(report_rows_by_sheet.fetch(3, []))
    )
  end

  private

  attr_accessor :get_transactions
  attr_accessor :process_transaction
  attr_accessor :create_csv

  def get_date(month, year)
    Time.zone.local(year.to_i, month.to_i)
  end

  def process_and_group(transactions)
    transactions.flat_map do |transaction|
      process_transaction.call(transaction)
    end.group_by(&:sheet_number)
  end
end
