require "rails_helper"

describe "Book details page" do
  let!(:book) { FactoryGirl.create(:book) }
  let!(:product) do
    FactoryGirl.create(
      :product,
      price_in_cents: 1599,
      currency: "USD",
      purchasable: book
    )
  end

  it "contains the book title" do
    visit book_path(book.slug)
    expect(page).to have_content(book.title)
  end

  describe "previews" do
    before do
      FactoryGirl.create(
        :chapter,
        book: book,
        number: 1,
        title: "Crazy interesting chapter"
      )
      FactoryGirl.create(
        :chapter,
        book: book,
        number: 2,
        title: "Best chapter in the book"
      )
    end

    it "displays chapters" do
      visit book_path(book.slug)
      expect(page).to have_content("Crazy interesting chapter")
      expect(page).to have_content("Best chapter in the book")
    end
  end
end
