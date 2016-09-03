require "rails_helper"

describe "View all books" do
  let!(:entreprenerd) do
    FactoryGirl.create(:book, title: "Entreprenerd", slug: "entreprenerd")
  end
  let!(:programmer) do
    FactoryGirl.create(:book, title: "Programmer", slug: "programmer")
  end

  it "links to all the books" do
    visit books_path
    expect(page).to have_content("Entreprenerd")
    expect(page).to have_content("Programmer")
  end
end
