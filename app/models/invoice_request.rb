class InvoiceRequest < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :order, :company_name, :address, :country
  validate :vat_id_required_in_eu

  def vat_id_required_in_eu
    if eu_country? && vat_id.blank?
      errors.add(:vat_id, "is required for countries in the EU")
    end
  end

  def eu_country?
    return false if country.blank?
    country_object = ISO3166::Country.find_country_by_name(country)
    country_object.eu_member
  end
end
