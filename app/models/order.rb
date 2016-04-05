class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  belongs_to :user

  validates_presence_of :user
end
