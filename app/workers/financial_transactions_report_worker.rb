class FinancialTransactionsReportWorker
  include Sidekiq::Worker

  def perform(month, year)
    DI.get(GenerateFinancialTransactionsReport).call(month, year)
  end
end
