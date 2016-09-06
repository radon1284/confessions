class GenerateFinancialTransactionsReport
  def self.build
    new
  end

  def call(month, year)
    FinancialTransactionsReport.create!(name: "#{year}-#{month}")
  end
end
