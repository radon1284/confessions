require "rails_helper"

describe "Order details page" do
  let!(:product) { FactoryGirl.create(:product) }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) do
    FactoryGirl.create(:order_item, product: product, order: order)
  end

  it "shows the names of purchased products" do
    visit order_path(order)
    expect(page).to have_content(product.display_name)
  end

  it "allows to download the PDF content" do
    product.purchasable.update!(
      content_pdf: File.open(file_fixture_path("book1.pdf"))
    )
    visit order_path(order)
    click_on "Download PDF"
    expect(page.response_headers["Content-Type"])
      .to eq "application/pdf"
  end

  it "allows to download the EPUB content" do
    product.purchasable.update!(
      content_epub: File.open(file_fixture_path("book1.epub"))
    )
    visit order_path(order)
    click_on "Download EPUB"
    expect(page.response_headers["Content-Type"])
      .to eq "application/epub+zip"
  end

  it "allows to download the MOBI content" do
    product.purchasable.update!(
      content_epub: File.open(file_fixture_path("book1.epub"))
    )
    visit order_path(order)
    click_on "Download MOBI"
    expect(page.response_headers["Content-Type"])
      .to eq "application/x-mobipocket-ebook"
  end
end
