class StaticPagesController < ApplicationController
  def impressum
  end

  def about
  end

  def privacy_policy
  end

  def home
    articles = Article.order(:created_at).last(10)
    render(
      locals: {
        articles: articles
      }
    )
  end

  def terms
  end
end
