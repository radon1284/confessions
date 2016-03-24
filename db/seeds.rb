Product.create!(
  purchasable: Book.create!(slug: "cto", title: "CTO"),
  price_in_cents: 76_543,
  currency: "USD"
)

Product.create!(
  purchasable: Book.create!(slug: "cmo", title: "CMO"),
  price_in_cents: 87_654,
  currency: "USD"
)
