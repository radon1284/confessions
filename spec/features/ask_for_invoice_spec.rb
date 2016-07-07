require "rails_helper"

describe "Ask for invoice" do
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) { FactoryGirl.create(:order_item, order: order) }

  it "creates new entry in the database" do
    visit order_path(order)
    click_on "Ask for invoice"
    fill_in "Company name", with: "Sunday Coding Adam Niedzielski"
    fill_in "Address", with: "Kościuszki 18/5 95-200 Pabianice"
    select "Poland", from: "Country"
    fill_in "VAT ID", with: "PL7312047877"

    expect { click_on "Generate" }.to change { InvoiceRequest.count }.by(1)
  end

  it "requires VAT ID for countries in the EU" do
    visit order_path(order)
    click_on "Ask for invoice"
    fill_in "Company name", with: "Sunday Coding Adam Niedzielski"
    fill_in "Address", with: "Kościuszki 18/5 95-200 Pabianice"
    select "Poland", from: "Country"
    click_on "Generate"

    expect(page).to have_content("VAT ID is required for countries in the EU")
  end

  it "does not require VAT ID for countries outside the EU" do
    visit order_path(order)
    click_on "Ask for invoice"
    fill_in "Company name", with: "Sunday Coding Adam Niedzielski"
    fill_in "Address", with: "Kościuszki 18/5 95-200 Pabianice"
    select "United States", from: "Country"

    expect { click_on "Generate" }.to change { InvoiceRequest.count }.by(1)
  end
end
