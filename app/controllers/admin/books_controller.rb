class Admin::BooksController < Admin::BaseController
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

  def update
    book = Book.find(params.fetch(:id))
    if book.update(book_params)
      redirect_to admin_book_url(book), notice: "Book was updated."
    else
      handle_error(book)
    end
  end

  def download_pdf
    book = Book.find(params.fetch(:id))
    redirect_to book.content_pdf.download_url
  end

  private

  def book_params
    params.fetch(:book, {}).permit(:content_pdf)
  end

  def handle_error(book)
    render(
      :show,
      locals: {
        book: book
      }
    )
  end
end
