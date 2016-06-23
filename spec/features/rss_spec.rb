require 'rails_helper'
describe "RSS Feed" do
  let!(:article) { FactoryGirl.create(:article) }

  it "works" do
    visit "/feed.rss"
    expect(Nokogiri.parse(page.body).errors).to be_empty
  end
end
