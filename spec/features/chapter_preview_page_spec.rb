require "rails_helper"

describe "Chapter preview page" do
  let!(:chapter) do
    FactoryGirl.create(
      :chapter,
      content_html: "<h1>Best chapter</h1>"
    )
  end

  it "shows chapter content" do
    visit book_chapter_path(chapter.book.slug, chapter.number)
    expect(page).to have_content("Best chapter")
    expect(page).to have_no_content("<h1>")
  end
end
