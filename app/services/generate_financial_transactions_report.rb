class GenerateFinancialTransactionsReport
  STRIPE_FEE_CODE = 4971
  WITHDRAWAL_CODE = 1360
  GERMANY_PURCHASE_CODE = 8400
  EU_PURCHASE_CODE = 8331
  OUTSIDE_EU_PURCHASE_CODE = 8338

  def self.build
    new
  end

  def call(month, year)
    FinancialTransactionsReport.create!(name: "#{year}-#{month}")
  end
end
