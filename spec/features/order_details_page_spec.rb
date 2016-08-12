require "rails_helper"

describe "Order details page" do
  let!(:book) { FactoryGirl.create(:book) }
  let!(:product) { FactoryGirl.create(:product, purchasable: book) }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) do
    FactoryGirl.create(:order_item, product: product, order: order)
  end

  context "when order is post-processed" do
    before do
      FactoryGirl.create(
        :watermarked_book,
        order: order,
        book: book,
        content_pdf: File.open(file_fixture("book1.pdf")),
        content_epub: File.open(file_fixture("book1.epub")),
        content_mobi: File.open(file_fixture("book1.mobi"))
      )
    end
    it "shows the names of purchased products" do
      visit order_path(order)
      expect(page).to have_content(product.display_name)
    end

    it "allows to download the PDF content" do
      visit order_path(order)
      click_on "Download PDF"
      expect(page.response_headers["Content-Type"])
        .to eq "application/pdf"
    end

    it "allows to download the EPUB content" do
      visit order_path(order)
      click_on "Download EPUB"
      expect(page.response_headers["Content-Type"])
        .to eq "text/plain"
    end

    it "allows to download the MOBI content" do
      visit order_path(order)
      click_on "Download MOBI"
      expect(page.response_headers["Content-Type"])
        .to eq "text/plain"
    end
  end
end
