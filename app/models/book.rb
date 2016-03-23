class Book < ActiveRecord::Base
  validates_presence_of :slug, :title
end
