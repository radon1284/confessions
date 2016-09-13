class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :price_in_cents, :currency, :product, :order, presence: true

  def price
    Money.new(price_in_cents, currency)
  end
end
