class BooksController < ApplicationController
  def show
    book = Book.find_by!(slug: params.fetch(:id))
    render(
      locals: {
        book: book
      }
    )
  end
end
