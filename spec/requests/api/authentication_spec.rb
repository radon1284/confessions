require "rails_helper"

describe "Authentication - API" do
  it "does not allow requests without a correct token" do
    patch(api_book_path("some-slug"), token: "wrong")
    expect(response.status).to eq 401
  end
end
