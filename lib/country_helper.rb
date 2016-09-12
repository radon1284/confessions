class CountryHelper
  def self.eu_country?(country_code)
    country_object = ISO3166::Country.find_country_by_alpha2(country_code)
    country_object.eu_member
  end
end
