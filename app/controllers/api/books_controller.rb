class API::BooksController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :check_token

  def update
    book = Book.find_by!(slug: params.fetch(:id))
    file = Base64EncodedFile.parse(params.fetch(:content_pdf), "book.pdf")
    book.update!(content_pdf: file)
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
