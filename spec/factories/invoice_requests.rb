FactoryGirl.define do
  factory :invoice_request do
    order
    company_name "Acme"
    address "Fifth Avenue 21"
    country "Greece"
    vat_id "XX123456789"
  end
end
