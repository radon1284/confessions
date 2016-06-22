require "rails_helper"

describe "Photo Management" do

  before do
    sign_in_admin
  end

  it "lets you create a new photo " do
    visit new_admin_photo_path
    attach_file :photo_file, file_fixture_path("checkmark.png")
    click_on "Create Photo"
    expect(page).to have_text(Photo.last.file.url)
  end

  it "lets you browse and then remove an existing photo" do
    photo = FactoryGirl.create(:photo)
    visit admin_photos_path
    expect(page).to have_text(photo.file.url)
    click_on "Destroy"
    expect(page).not_to have_text(photo.file.url)
  end
end
