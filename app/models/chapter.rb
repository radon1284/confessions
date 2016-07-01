class Chapter < ActiveRecord::Base
  belongs_to :book

  validates_presence_of :book, :number, :content_html, :title
end
