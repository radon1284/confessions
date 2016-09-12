class GenerateFinancialTransactionsReport
  class CalculatePurchaseCode
    def self.build
      new
    end

    def call(country_code)
      return GERMANY_PURCHASE_CODE if country_code == "DE"

      if CountryHelper.eu_country?(country_code)
        EU_PURCHASE_CODE
      else
        OUTSIDE_EU_PURCHASE_CODE
      end
    end
  end
end
