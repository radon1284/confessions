class FinancialTransactionsReport < ApplicationRecord
  validates_presence_of :name, :first_sheet, :second_sheet, :third_sheet

  mount_uploader :first_sheet, CSVReportUploader
  mount_uploader :second_sheet, CSVReportUploader
  mount_uploader :third_sheet, CSVReportUploader
end
