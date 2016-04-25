class API::BooksController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :check_token

  def update
    book = Book.find_by!(slug: params.fetch(:id))
    DI.get(ReplaceBookContent).call(book, params)
    render json: {}
  end

  private

  def check_token
    render(
      json: {},
      status: :unauthorized
    ) unless params[:token] == ENV.fetch("API_TOKEN")
  end
end
