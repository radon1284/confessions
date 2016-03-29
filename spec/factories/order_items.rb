FactoryGirl.define do
  factory :order_item do
    product
    order
    price_in_cents 10_000
    currency "USD"
  end
end
