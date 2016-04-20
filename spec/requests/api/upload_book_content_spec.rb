require "rails_helper"

describe "Upload book content via API" do
  let!(:book) { FactoryGirl.create(:book) }

  it "accepts Base64 encoded file" do
    dummy_file_content = "123"
    encoded = Base64.encode64(dummy_file_content)
    patch(
      api_book_path(book.slug),
      content_pdf: encoded,
      content_epub: encoded,
      content_mobi: encoded,
      token: ENV.fetch("API_TOKEN")
    )
    expect(response.status).to eq 200
    expect(book.reload.content_pdf).to be_present
    expect(book.reload.content_epub).to be_present
    expect(book.reload.content_mobi).to be_present
  end
end
