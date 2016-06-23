require "rails_helper"
describe "Article Management" do
  before do
    sign_in_admin
  end

  it "lets you create a new article", js: true do
    visit new_admin_article_path
    fill_in_epiceditor_field "
      ## Use More Images
      One of the problems with original janki was...
    "
    fill_in "Title", with: "Janki Method Refined"
    fill_in "Slug", with: "janki-method-refined"
    fill_in "Subtitle", with: "Changes to original janki"
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

  private

  def fill_in_epiceditor_field(text)
    # Use CSS attribute prefix selector
    # (^=) to find iframe with id
    # beginning with 'epiceditor-' to
    # match first parent iframe in page
    parent_iframe = find('iframe[id^=epiceditor-]')

    within_frame(parent_iframe) do
      child_iframe_id = 'epiceditor-editor-frame'

      within_frame(child_iframe_id) do
        fill_in 'body[contenteditable]', with: text
      end
    end
  end
end
