class CreateFinancialTransactionsReports < ActiveRecord::Migration[5.0]
  def change
    create_table :financial_transactions_reports do |t|
      t.text :name

      t.timestamps
    end
  end
end
