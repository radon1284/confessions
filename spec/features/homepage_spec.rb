require "rails_helper"

describe "Homepage" do
  it "displays the personal information" do
    visit root_path
    expect(page).to have_content("I call myself an analyst")
  end
end
