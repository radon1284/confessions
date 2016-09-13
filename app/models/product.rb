class Product < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true
  has_many :order_items, dependent: :destroy

  validates :price_in_cents, :currency, :purchasable, presence: true
  validates :price_in_cents, numericality: true

  def price
    Money.new(price_in_cents, currency)
  end

  def display_name
    purchasable.title
  end
end
