FactoryGirl.define do
  factory :financial_transactions_report do
    name "2015-6"
    first_sheet { File.open(file_fixture("report.csv")) }
    second_sheet { File.open(file_fixture("report.csv")) }
    third_sheet { File.open(file_fixture("report.csv")) }
  end
end
