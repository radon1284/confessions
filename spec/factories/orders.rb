FactoryGirl.define do
  factory :order do
    user
    sequence(:invoice_number) { |n| "INVOICE-#{n}" }
    ip_address "127.0.0.1"
  end
end
