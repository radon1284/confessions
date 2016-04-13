require "rails_helper"

describe "Upload book content" do
  let!(:book) { FactoryGirl.create(:book) }

  before do
    sign_in_admin
  end

  it "stores the PDF file" do
    visit admin_books_path
    click_on book.title
    attach_file :book_content_pdf, file_fixture_path("book1.pdf")
    click_on "Replace"
    expect(book.reload.content_pdf).to be_present
  end

  it "allows to download the current content" do
    book.update!(content_pdf: File.open(file_fixture_path("book1.pdf")))
    visit admin_book_path(book)
    click_on "download"
    expect(page.response_headers["Content-Type"])
      .to eq "application/pdf"
  end
end
