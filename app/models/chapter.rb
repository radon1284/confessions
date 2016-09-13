class Chapter < ActiveRecord::Base
  belongs_to :book

  validates :book, :number, :content_html, :title, :slug, presence: true
  validates :slug, uniqueness: { scope: :book }
end
