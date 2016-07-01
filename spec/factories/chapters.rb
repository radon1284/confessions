FactoryGirl.define do
  factory :chapter do
    book
    number 1
    content_html "<h1>First chapter</h1><p>Awesome content</p>"
    title "This Is Amazing Chapter"
    slug { SecureRandom.hex }
  end
end
