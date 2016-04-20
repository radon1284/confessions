class API::BooksController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :check_token

  def update
    book = Book.find_by!(slug: params.fetch(:id))
    pdf = Base64EncodedFile.parse(params.fetch(:content_pdf), "book.pdf")
    epub = Base64EncodedFile.parse(params.fetch(:content_epub), "book.epub")
    mobi = Base64EncodedFile.parse(params.fetch(:content_mobi), "book.mobi")
    book.update!(content_pdf: pdf, content_epub: epub, content_mobi: mobi)
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
