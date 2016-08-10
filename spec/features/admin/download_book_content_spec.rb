require "rails_helper"

describe "Download book content" do
  let!(:book) do
    FactoryGirl.create(
      :book,
      content_pdf: File.open(file_fixture("book1.pdf"))
    )
  end

  before do
    sign_in_admin
  end

  it "allows to download the current content" do
    visit admin_books_path
    click_on book.title
    click_on "download"
    expect(page.response_headers["Content-Type"])
      .to eq "application/pdf"
  end
end
