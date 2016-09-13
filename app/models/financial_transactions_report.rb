class FinancialTransactionsReport < ApplicationRecord
  validates :name, :first_sheet, :second_sheet, :third_sheet, presence: true

  mount_uploader :first_sheet, CSVReportUploader
  mount_uploader :second_sheet, CSVReportUploader
  mount_uploader :third_sheet, CSVReportUploader
end
