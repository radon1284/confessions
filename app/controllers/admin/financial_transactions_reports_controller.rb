module Admin
  class FinancialTransactionsReportsController < BaseController
    def new
    end

    def create
      FinancialTransactionsReportWorker.perform_async(
        params.fetch("date").fetch("month"),
        params.fetch("date").fetch("year")
      )
      redirect_to(
        admin_financial_transactions_reports_url,
        notice: "Report generation has been scheduled. \
          The report will appear in this page when it is finished"
      )
    end

    def index
      financial_transactions_reports =
        FinancialTransactionsReport
        .order(created_at: :desc)
        .page(params[:page])

      render(
        locals: {
          financial_transactions_reports: financial_transactions_reports
        }
      )
    end
  end
end
