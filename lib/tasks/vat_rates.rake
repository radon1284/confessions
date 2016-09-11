namespace :vat_rates do
  desc "Save VAT rates in the database"
  task fetch: :environment do
    DI.get(FetchVATRates).call(Time.current)
  end
end
