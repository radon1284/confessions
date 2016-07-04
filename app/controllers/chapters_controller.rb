class ChaptersController < ApplicationController
  def show
    book = Book.find_by!(slug: params.fetch(:book_id))
    chapter = book.chapters.find_by!(slug: params.fetch(:id))
    render(
      locals: {
        chapter: chapter,
        book: book,
        navigation: build_navigation(book, chapter)
      }
    )
  end

  private

  Navigation = Struct.new(:all_chapters, :previous_chapter, :next_chapter)

  def build_navigation(book, current_chapter)
    Navigation.new(
      book.chapters,
      book.chapters.find_by(number: current_chapter.number - 1),
      book.chapters.find_by(number: current_chapter.number + 1)
    )
  end
end
