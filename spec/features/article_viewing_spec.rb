require "rails_helper"

describe "Article Viewing" do
  describe "single article page" do
    let!(:article) { FactoryGirl.create(:article, title: "Janki Method") }

    it "displays article title" do
      visit article_path(article.slug)
      expect(page).to have_text("Janki Method")
    end
  end

  describe "all articles list page" do
    let!(:article) { FactoryGirl.create(:article, title: "Janki Method") }

    it "displays article title" do
      visit articles_path
      expect(page).to have_text("Janki Method")
    end
  end

  describe "filtering articles by tag" do
    let!(:programming_article) do
      FactoryGirl.create(:article, title: "Programming Wisdom", slug: "1")
    end
    let!(:marketing_article) do
      FactoryGirl.create(:article, title: "Marketing Wisdom", slug: "2")
    end
    let!(:programming_tag) { FactoryGirl.create(:tag, name: "Programming") }
    let!(:marketing_tag) { FactoryGirl.create(:tag, name: "Marketing") }

    before do
      Tagging.create!(tag: programming_tag, article: programming_article)
      Tagging.create!(tag: marketing_tag, article: marketing_article)
    end

    it "displays only the articles for the given tag" do
      visit articles_path(tag_name: "Marketing")
      expect(page).to have_content("Marketing Wisdom")
      expect(page).to have_no_content("Programming Wisdom")
    end
  end
end
