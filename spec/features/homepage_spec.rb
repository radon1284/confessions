require "rails_helper"

describe "Homepage" do
  let!(:book) do
    FactoryGirl.create(:book, slug: "awesome-book", title: "Awesome book")
  end

  it "displays the list of books" do
    visit root_path
    expect(page).to have_content("Awesome book")
  end
end
