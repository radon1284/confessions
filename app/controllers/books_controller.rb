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
    book = find_book_by_order
    redirect_to book.content_pdf.download_url
  end

  def download_epub
    book = find_book_by_order
    redirect_to book.content_epub.download_url
  end

  def download_mobi
    book = find_book_by_order
    redirect_to book.content_mobi.download_url
  end

  private

  def find_book_by_order
    order = Order.find(params.fetch(:order_id))
    order.books.find(params.fetch(:id))
  end
end
