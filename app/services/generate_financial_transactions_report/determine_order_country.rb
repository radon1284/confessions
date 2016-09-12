class GenerateFinancialTransactionsReport
  class DetermineOrderCountry
    class CountryUnknownError < StandardError; end

    def self.build
      new
    end

    def call(order)
      invoice_request = latest_invoice_request(order)
      if invoice_request.present?
        return ISO3166::Country.find_country_by_name(
          invoice_request.country
        ).alpha2
      end

      order.country_from_stripe.presence ||
        order.country_from_ip.presence ||
        raise(
          CountryUnknownError,
          "Unable to determine country for order with ID #{order.id}"
        )
    end

    private

    def latest_invoice_request(order)
      order.invoice_requests.order(:created_at).last
    end
  end
end
