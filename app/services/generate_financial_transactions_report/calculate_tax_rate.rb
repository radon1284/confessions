class GenerateFinancialTransactionsReport
  class CalculateTaxRate
    def self.build
      new
    end

    def call(country_code, date)
      return nil unless eu_country?(country_code)

      vat_rates(date.beginning_of_day)
        .fetch(country_code)
        .fetch("standard_rate")
    rescue ActiveRecord::RecordNotFound, KeyError
      raise "Cannot find the rate for #{country_code} #{date}"
    end

    private

    def eu_country?(country_code)
      country_object = ISO3166::Country.find_country_by_alpha2(country_code)
      country_object.eu_member
    end

    def vat_rates(date)
      VATRateResponse.find_by!(date: date).payload.fetch("rates")
    end
  end
end
