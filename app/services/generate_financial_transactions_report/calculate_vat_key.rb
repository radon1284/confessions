class GenerateFinancialTransactionsReport
  class CalculateVATKey
    def self.build
      new
    end

    def call(country_code)
      return nil if country_code == "DE"

      if CountryHelper.eu_country?(country_code)
        44
      else
        nil
      end
    end
  end
end
