class FetchCountryFromStripe
  def self.build
    new
  end

  def call(order)
    charge = Stripe::Charge.retrieve(order.stripe_charge_identifier)
    country_code = charge.source.country

    if country_code.blank?
      Rollbar.warning("Stripe country is empty for #{charge.id}")
      return
    end

    order.update!(country_from_stripe: country_code)
  end
end
