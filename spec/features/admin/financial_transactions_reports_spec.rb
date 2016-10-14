require "rails_helper"

describe "Financial transactions reports" do
  before do
    sign_in_admin
  end

  describe "scheduling generation of the report" do
    it "enqueues a background job" do
      visit new_admin_financial_transactions_report_path
      select "August", from: "Month"
      select "2016", from: "Year"
      expect { click_on "Schedule" }
        .to change { FinancialTransactionsReportWorker.jobs.size }.by(1)
    end
  end

  describe "browsing generated reports" do
    let!(:report) do
      FactoryGirl.create(:financial_transactions_report, name: "2016-8")
    end

    it "displays name of a report" do
      visit admin_financial_transactions_reports_path
      expect(page).to have_content(report.name)
    end

    it "displays links to download each sheet of the report" do
      visit admin_financial_transactions_reports_path
      expect(page).to have_link("2016-8 Transactions-and-refunds")
      expect(page).to have_link("2016-8 Stripe Fees")
      expect(page).to have_link("2016-8 Withdrawals")
    end
  end
end
