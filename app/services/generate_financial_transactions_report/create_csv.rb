class GenerateFinancialTransactionsReport
  class CreateCSV
    HEADERS = [
      "Date", "Invoice", "Name", "Country", "Amount", "VAT-key",
      "account", "counter acc", "tax rate"
    ].freeze

    def self.build
      new(DI.get(FormatReportRow))
    end

    def initialize(format_report_row)
      self.format_report_row = format_report_row
    end

    def call(report_rows)
      InMemoryFile.new(
        string_with_csv_data(report_rows),
        "sheet.csv"
      )
    end

    private

    attr_accessor :format_report_row

    def string_with_csv_data(report_rows)
      CSV.generate do |csv|
        csv << HEADERS
        report_rows.each do |row|
          csv << format_report_row.call(row)
        end
      end
    end
  end
end
