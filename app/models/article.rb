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
    includes(:tags).where(tags: { id: tags })
  end

  def self.related_selection(article)
    num_of_articles = 3
    tagged_articles = tagged_with(article.tags) - [article]
    number_tagged_articles_found = tagged_articles.count
    if number_tagged_articles_found >= 3
      tagged_articles.limit(num_of_articles)
    else
      tagged_articles + random_selection(num_of_articles -
                                         number_tagged_articles_found,
                                         ([article] + tagged_articles))
    end
  end

  def self.random_selection(num, excluded_articles)
    order("RANDOM()")
      .where
      .not(id: excluded_articles)
      .limit(num)
  end
  private_class_method :random_selection
end
