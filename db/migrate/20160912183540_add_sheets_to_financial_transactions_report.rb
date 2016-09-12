class AddSheetsToFinancialTransactionsReport < ActiveRecord::Migration[5.0]
  def change
    add_column :financial_transactions_reports, :first_sheet, :text
    add_column :financial_transactions_reports, :second_sheet, :text
    add_column :financial_transactions_reports, :third_sheet, :text
  end
end
