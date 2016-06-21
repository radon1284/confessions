class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render(
      locals: {
        articles: articles
      }
    )
  end

  def feed
    articles = Article.all
    respond_to do |format|
      format.rss { render :layout => false,
                   locals:
                   { articles: articles }
      }
    end
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
