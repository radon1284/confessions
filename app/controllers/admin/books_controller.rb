module Admin
  class BooksController < Admin::BaseController
    def index
      books = Book.all
      render(
        locals: {
          books: books
        }
      )
    end

    def show
      book = Book.find(params.fetch(:id))
      render(
        locals: {
          book: book
        }
      )
    end

    def download_pdf
      book = Book.find(params.fetch(:id))
      redirect_to book.content_pdf.download_url
    end

    def download_epub
      book = Book.find(params.fetch(:id))
      redirect_to book.content_epub.download_url
    end

    def download_mobi
      book = Book.find(params.fetch(:id))
      redirect_to book.content_mobi.download_url
    end
  end
end
