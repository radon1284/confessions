class GenerateFinancialTransactionsReport
  class ReportRow
    attr_accessor(
      :date, :invoice_number, :name, :country_code, :amount,
      :vat_key, :transaction_type_code, :tax_rate, :sheet_number
    )

    def initialize(
      date:, invoice_number: nil, name: nil, country_code: nil, amount:,
      vat_key: nil, transaction_type_code:, tax_rate: nil, sheet_number:
    )
      self.date = date
      self.invoice_number = invoice_number
      self.name = name
      self.country_code = country_code
      self.amount = amount
      self.vat_key = vat_key
      self.transaction_type_code = transaction_type_code
      self.tax_rate = tax_rate
      self.sheet_number = sheet_number
    end
  end
end
