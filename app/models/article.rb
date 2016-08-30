class Article < ActiveRecord::Base
  validates_presence_of :slug, :title, :body
  validates_uniqueness_of :slug

  has_many :taggings
  has_many :tags, through: :taggings

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
