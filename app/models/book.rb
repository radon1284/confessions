class Book < ActiveRecord::Base
  has_one :product, as: :purchasable

  validates_presence_of :slug, :title
end
