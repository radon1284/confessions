FactoryGirl.define do
  factory :chapter do
    book
    number 1
    content_html "<h1>First chapter</h1><p>Awesome content</p>"
  end
end
