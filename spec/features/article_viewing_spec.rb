require "rails_helper"

describe "Article Viewing" do

   let!(:article) { FactoryGirl.create(
      :article,
      title: "Janki Method"
    )
   }

  it "lets you view an article" do
    visit article_path(article.slug)
    expect(page).to have_text("Janki Method")
  end

  it "lets you view a list of articles" do
    visit articles_path(article.slug)
    expect(page).to have_text("Janki Method")
  end
end
