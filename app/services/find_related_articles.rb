class FindRelatedArticles
  MAXIMUM_NUMBER_OF_ARTICLES = 3

  def self.build
    new(MAXIMUM_NUMBER_OF_ARTICLES)
  end

  def initialize(number_of_articles)
    self.number_of_articles = number_of_articles
  end

  def call(article)
    priority_articles = articles_with_tags(article)
    other_articles = random_articles(article, priority_articles.map(&:id))
    (priority_articles + other_articles).first(number_of_articles)
  end

  private

  attr_accessor :number_of_articles

  def articles_with_tags(article)
    Article
      .includes(:tags)
      .published
      .where(tags: { id: article.tag_ids })
      .where
      .not(id: article.id)
      .order("RANDOM()")
      .limit(number_of_articles)
      .to_a
  end

  def random_articles(article, already_selected_ids)
    Article
      .published
      .where
      .not(id: already_selected_ids + [article.id])
      .order("RANDOM()")
      .limit(number_of_articles)
      .to_a
  end
end
