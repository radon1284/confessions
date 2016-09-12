class GenerateFinancialTransactionsReport
  class FormatReportRow
    def self.build
      new
    end

    def call(row)
      [
        row.date.strftime("%D"),
        row.invoice_number,
        row.name,
        format_country_code(row.country_code),
        Money.new(row.amount).to_s,
        row.vat_key,
        row.transaction_type_code,
        STRIPE_COUNTER_CODE,
        row.tax_rate
      ]
    end

    private

    def format_country_code(country_code)
      return "EL" if country_code == "GR"
      country_code
    end
  end
end
