class ChaptersController < ApplicationController
  def show
    book = Book.find_by!(slug: params.fetch(:book_id))
    chapter = book.chapters.find_by!(slug: params.fetch(:id))
    next_chapter = book.chapters.find_by(number: chapter.number + 1)
    previous_chapter = book.chapters.find_by(number: chapter.number - 1)
    all_chapters = book.chapters.only("slug,number")
    render(
      locals: {
        chapter: chapter,
        book: book,
        next_chapter: next_chapter,
        previous_chapter: previous_chapter,
        all_chapters: all_chapters
      }
    )
  end
end
