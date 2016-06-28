class StaticPagesController < ApplicationController
  def impressum
  end

  def about
  end

  def privacy_policy
  end

  def home
    articles = Article.order(:created_at).last(10)
    books = Book.order(:created_at)
    render(
      locals: {
        articles: articles,
        books: books
      }
    )
  end

  def terms
  end
end
