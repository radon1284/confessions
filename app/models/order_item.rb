class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates_presence_of :price_in_cents, :currency, :product, :order

  def price
    Money.new(price_in_cents, currency)
  end
end
