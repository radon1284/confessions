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

  def self.tagged_with(tags)
    includes(:tags).where(tags: { id: tags }).uniq
  end

  def self.random_selection(preferred_tags: nil)
    num_of_articles = 3
    if !preferred_tags
      order("RANDOM()").limit(num_of_articles)
    else
      tagged_articles = tagged_with(preferred_tags)
      number_tagged_articles_found = tagged_articles.count
      if number_tagged_articles_found >= 3
        articles.limit(num_of_articles)
      else
        extra_articles = order("RANDOM()").limit(num_of_articles -
                                                number_tagged_articles_found) -
                         tagged_articles
        tagged_articles + extra_articles
      end
    end
  end
end
