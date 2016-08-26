class ArticlesController < ApplicationController
  def index
    tags = Tag.all
    articles = if params[:tag_name]
                 Tag.where(name: params[:tag_name]).take.articles
               else
                 Article.order(created_at: :desc)
               end
    render(
      locals: {
        articles: articles,
        tags: tags
      }
    )
  end

  def feed
    articles = Article.all
    respond_to do |format|
      format.rss do
        render layout: false,
          locals: { articles: articles }
      end
    end
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
end
