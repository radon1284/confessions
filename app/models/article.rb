class Article < ActiveRecord::Base
  validates_presence_of :slug, :title, :body
  validates_uniqueness_of :slug

  def self.random_selection
    limit(3).order("RANDOM()")
  end
end
