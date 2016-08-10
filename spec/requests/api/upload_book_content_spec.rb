require "rails_helper"

describe "Upload book content via API" do
  let!(:book) { FactoryGirl.create(:book) }

  def dummy_encoded_file
    dummy_file_content = "123"
    Base64.encode64(dummy_file_content)
  end

  it "accepts Base64 encoded files" do
    patch(
      api_book_path(book.slug),
      params: {
        content_pdf: dummy_encoded_file,
        content_epub: dummy_encoded_file,
        content_mobi: dummy_encoded_file,
        previews: [
          { title: "This Is A Title", content: dummy_encoded_file }
        ],
        token: ENV.fetch("API_TOKEN")
      }
    )
    expect(response.status).to eq 200
    expect(book.reload.content_pdf).to be_present
    expect(book.reload.content_epub).to be_present
    expect(book.reload.content_mobi).to be_present
  end

  it "saves HTML previews of chapters" do
    patch(
      api_book_path(book.slug),
      params: {
        content_pdf: dummy_encoded_file,
        content_epub: dummy_encoded_file,
        content_mobi: dummy_encoded_file,
        previews: [
          { title: "This Is A Title", content: dummy_encoded_file }
        ],
        token: ENV.fetch("API_TOKEN")
      }
    )

    book.reload
    expect(book.chapters.count).to eq 1
    chapter = book.chapters.last
    expect(chapter.content_html).to eq "123"
    expect(chapter.title).to eq "This Is A Title"
    expect(chapter.number).to eq 1
    expect(chapter.slug).to eq "this-is-a-title"
  end
end
