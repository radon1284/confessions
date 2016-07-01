class ChaptersController < ApplicationController
  def show
    book = Book.find_by!(slug: params.fetch(:book_id))
    all_chapters = book.chapters.order(:number)
    chapter = all_chapters.find_by!(slug: params.fetch(:id))
    render(
      locals: {
        chapter: chapter,
        book: book,
        all_chapters: all_chapters
      }
    )
  end
end
