FactoryGirl.define do
  factory :product do
    currency "USD"
    price_in_cents 17_955
    association :purchasable, factory: :book
  end
end
