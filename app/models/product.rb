class Product < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true
  has_many :order_items, dependent: :destroy

  validates_presence_of :price_in_cents, :currency, :purchasable
  validates_numericality_of :price_in_cents

  def price
    Money.new(price_in_cents, currency)
  end

  def display_name
    purchasable.title
  end
end
