class GenerateFinancialTransactionsReport
  class ProcessTransaction
    def self.build
      new(
        DI.get(DetermineOrderCountry),
        DI.get(CalculatePurchaseCode),
        DI.get(CalculateVATKey),
        DI.get(CalculateTaxRate)
      )
    end

    def initialize(
      determine_order_country,
      calculate_purchase_code,
      calculate_vat_key,
      calculate_tax_rate
    )
      self.determine_order_country = determine_order_country
      self.calculate_purchase_code = calculate_purchase_code
      self.calculate_vat_key = calculate_vat_key
      self.calculate_tax_rate = calculate_tax_rate
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def call(transaction)
      case transaction.type
      when "charge", "refund"
        order = Order.find(transaction.order_id)
        country_code = determine_order_country.call(order)
        [
          ReportRow.new(
            date: transaction.date,
            amount: transaction.amount,
            transaction_type_code: calculate_purchase_code.call(country_code),
            invoice_number: order.invoice_number,
            country_code: country_code,
            vat_key: calculate_vat_key.call(country_code),
            tax_rate: calculate_tax_rate.call(country_code, transaction.date),
            sheet_number: 1
          ),
          ReportRow.new(
            date: transaction.date,
            amount: -transaction.fee_amount,
            transaction_type_code: STRIPE_FEE_CODE,
            invoice_number: order.invoice_number,
            country_code: country_code,
            vat_key: calculate_vat_key.call(country_code),
            sheet_number: 2
          )
        ]
      when "withdrawal"
        [
          ReportRow.new(
            date: transaction.date,
            amount: transaction.amount,
            transaction_type_code: WITHDRAWAL_CODE,
            sheet_number: 3
          )
        ]
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    attr_accessor :determine_order_country
    attr_accessor :calculate_purchase_code
    attr_accessor :calculate_vat_key
    attr_accessor :calculate_tax_rate
  end
end
