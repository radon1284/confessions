class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render(
      locals: {
        articles: articles
      }
    )
  end

  def show
    article = Article.find_by!(slug: params.fetch(:slug))
    render(
      locals: {
        article: article,
      }
    )
  end
end
