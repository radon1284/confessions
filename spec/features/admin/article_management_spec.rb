require "rails_helper"

describe "Article Management" do

  before do
    sign_in_admin
  end

  it "lets you create a new article" do
    visit new_admin_article_path
    fill_in "Title", with: "Janki Method Refined"
    fill_in "Slug", with: "janki-method-refined"
    fill_in "Subtitle", with: "Changes to original janki"
    fill_in "Body", with: %Q{
    ## Use More Images
    One of the problems with original janki was...
    }
    click_on "Send"
    expect(page).to have_text("Successfully created article")
    expect(page).to have_text("Janki Method Refined")
  end

  it "lets you edit an existing article" do
    article = FactoryGirl.create(
      :article,
      title: "Janki Method"
    )
    visit edit_admin_article_path(article.slug)
    fill_in "Title", with: "Hanky Method"
    click_on "Send"
    expect(page).to have_text("Successfully updated article")
    expect(page).to have_text("Hanky")
  end
end
