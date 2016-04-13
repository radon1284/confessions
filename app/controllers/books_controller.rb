class BooksController < ApplicationController
  def index
    books = Book.all
    render(
      locals: {
        books: books
      }
    )
  end

  def show
    book = Book.find_by!(slug: params.fetch(:id))
    render(
      locals: {
        book: book
      }
    )
  end

  def download_pdf
    order = Order.find(params.fetch(:order_id))
    book = order.books.find(params.fetch(:id))
    redirect_to book.content_pdf.download_url
  end
end
