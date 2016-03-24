class Product < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true

  validates_presence_of :price_in_cents, :currency, :purchasable
  validates_numericality_of :price_in_cents

  def price
    Money.new(price_in_cents, currency)
  end
end
