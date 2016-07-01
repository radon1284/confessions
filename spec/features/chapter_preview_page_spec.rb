require "rails_helper"

describe "Chapter preview page" do
  let!(:book) { FactoryGirl.create(:book) }
  let!(:chapter) do
    FactoryGirl.create(
      :chapter,
      content_html: "<h1>Best chapter</h1>",
      book: book
    )
  end

  it "shows chapter content" do
    visit book_chapter_path(book.slug, chapter.slug)
    expect(page).to have_content("Best chapter")
    expect(page).to have_no_content("<h1>")
  end

  describe "navigation" do
    let!(:other_chapter) do
      FactoryGirl.create(
        :chapter,
        title: "Other chapter",
        number: 2,
        book: book
      )
    end

    it "links to other chapters in this book" do
      visit book_chapter_path(book.slug, chapter.slug)
      expect(page).to have_content("Chapter 2 - Other chapter")
    end
  end
end
