class GenerateFinancialTransactionsReport
  class CalculateTaxRate
    def self.build
      new
    end

    def call(country_code, date)
      return nil unless CountryHelper.eu_country?(country_code)

      vat_rates(date.beginning_of_day)
        .fetch(country_code)
        .fetch("standard_rate")
    rescue ActiveRecord::RecordNotFound, KeyError
      raise "Cannot find the rate for #{country_code} #{date}"
    end

    private

    def vat_rates(date)
      VATRateResponse.find_by!(date: date).payload.fetch("rates")
    end
  end
end
