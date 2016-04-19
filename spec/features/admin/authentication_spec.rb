require "rails_helper"

describe "Authentication" do
  it "does not allow unauthenticated requests" do
    visit admin_books_path
    expect(page.status_code).to eq 401
  end
end
