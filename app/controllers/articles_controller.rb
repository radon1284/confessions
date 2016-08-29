class ArticlesController < ApplicationController
  def index
    tags = Tag.all
    articles = articles_scope.order(created_at: :desc)
    render(
      locals: {
        articles: articles,
        tags: tags
      }
    )
  end

  def feed
    articles = Article.all
    render(
      locals: { articles: articles }
    )
  end

  def show
    article = Article.find_by!(slug: params.fetch(:slug))
    random_articles = Article.related_selection(article)
    render(
      locals: {
        article: article,
        random_articles: random_articles
      }
    )
  end

  private

  def articles_scope
    if params[:tag_name]
      Tag.find_by!(name: params[:tag_name]).articles
    else
      Article.all
    end
  end
end
