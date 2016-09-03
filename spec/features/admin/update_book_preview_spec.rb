require "rails_helper"

describe "Update book preview" do
  let!(:book) { FactoryGirl.create(:book) }

  before do
    sign_in_admin
  end

  it "allows to upload new PDF for preview" do
    visit edit_admin_book_path(book)
    attach_file "Content pdf preview", file_fixture("book1.pdf")
    expect { click_on "Send" }
      .to change { book.reload.content_pdf_preview.present? }
      .from(false)
      .to(true)
  end
end
