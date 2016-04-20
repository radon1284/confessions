require "rails_helper"

describe "Upload book content via API" do
  let!(:book) { FactoryGirl.create(:book) }

  it "accepts Base64 encoded file" do
    file = File.open(file_fixture_path("book1.pdf"))
    payload = Base64.encode64(file.read)
    patch(
      api_book_path(book.slug),
      content_pdf: payload,
      token: ENV.fetch("API_TOKEN")
    )
    expect(response.status).to eq 200
    expect(book.reload.content_pdf).to be_present
  end
end
