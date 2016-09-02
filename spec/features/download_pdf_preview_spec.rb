require "rails_helper"

describe "Download PDF preview" do
  let!(:book) do
    FactoryGirl.create(
      :book,
      content_pdf_preview: File.open(file_fixture("book1.pdf"))
    )
  end
  let!(:product) { FactoryGirl.create(:product, purchasable: book) }

  it "redirects to a PDF file" do
    visit book_path(book.slug)
    click_on "test-download-pdf-preview"
    expect(page.response_headers["Content-Type"]).to eq "application/pdf"
  end
end
