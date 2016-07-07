FactoryGirl.define do
  factory :order do
    user
    sequence(:invoice_number) { |n| "INVOICE-#{n}" }
  end
end
