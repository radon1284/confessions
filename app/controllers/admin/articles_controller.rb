class Admin::ArticlesController < Admin::BaseController
  def index
    articles = Article.order(created_at: :desc)
    render(
      locals: {
        articles: articles
      }
    )
  end

  def new
    article = Article.new
    render(
      locals: {
        article: article
      }
    )
  end

  def edit
    article = Article.find_by!(slug: params.fetch(:slug))
    render(
      locals: {
        article: article
      }
    )
  end

  def create
    article = Article.new(article_params)
    if article.save
      flash[:notice] = "Successfully created article"
      redirect_to article_path(article.slug)
    else
      flash[:alert] = "Errors creating your article"
      render :new,
             locals: { article: article }
    end
  end

  def update
    article = Article.find(params.fetch(:slug))
    if article.update_attributes(article_params)
      flash[:notice] = "Successfully updated article"
      redirect_to article_path(article.slug)
    else
      flash[:alert] = "Could not update article"
      render(:edit, locals: { article: article })
    end
  end

  private

  def article_params
    params.require(:article)
          .permit(:title, :slug, :short_description, :subtitle, :body)
  end
end
