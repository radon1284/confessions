FactoryGirl.define do
  factory :watermarked_book do
    book
    order
    content_pdf { File.open(file_fixture("book1.pdf")) }
    content_epub { File.open(file_fixture("book1.epub")) }
    content_mobi { File.open(file_fixture("book1.mobi")) }
  end
end
