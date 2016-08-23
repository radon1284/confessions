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

    def edit
      book = Book.find(params.fetch(:id))
      render(
        locals: {
          book: book
        }
      )
    end

    def update
      book = Book.find(params.fetch(:id))
      if book.update_attributes(book_params)
        flash[:notice] = "Successfully updated book"
        redirect_to admin_book_path(book)
      else
        flash[:alert] = "Could not update book"
        render(:edit, locals: { book: book })
      end
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

    private

    def book_params
      params.require(:book)
            .permit(:title, :content_pdf_preview)
    end
  end
end
