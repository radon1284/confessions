class BooksController < ApplicationController
  def index
    books = Book.all
    render(
      locals: {
        books: books
      }
    )
  end

  def marketing_for_programmers
    book = Book.find_by!(slug: params.fetch(:id))
    chapters = book.chapters.order(:number)
    use_minimised_layout
    render(
      locals: {
        book: book,
        chapters: chapters,
      }
    )
  end

  def show
    book = Book.find_by!(slug: params.fetch(:id))
    chapters = book.chapters.order(:number)
    render(
      locals: {
        book: book,
        chapters: chapters
      }
    )
  end

  def download_pdf_preview
    book = Book.find(params.fetch(:id))
    redirect_to book.content_pdf_preview.download_url
  end
end
