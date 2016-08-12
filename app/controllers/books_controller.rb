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
    chapters = book.chapters.order(:number)
    render(
      locals: {
        book: book,
        chapters: chapters
      }
    )
  end
end
