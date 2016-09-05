class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  belongs_to :user
  has_many(
    :books,
    through: :products,
    source: :purchasable,
    source_type: "Book"
  )
  has_many :watermarked_books
  has_many :invoice_requests

  validates_presence_of(
    :user,
    :invoice_number,
    :ip_address,
    :stripe_charge_identifier
  )

  def total
    order_items.map(&:price).sum
  end
end
