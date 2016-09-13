class Article < ActiveRecord::Base
  validates :slug, :title, :body, presence: true
  validates :slug, uniqueness: true

  has_many :taggings
  has_many :tags, through: :taggings

  scope :published, -> { where(published: true) }

  # Virtual attribute getter and setter
  def all_tags
    tags.map(&:name).join(", ")
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
