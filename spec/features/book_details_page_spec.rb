require "rails_helper"

describe "Book details page" do
  let!(:book) { FactoryGirl.create(:book, slug: "cto") }

  it "contains the book title" do
    visit book_path("cto")
    expect(page).to have_content("CTO")
  end
end
