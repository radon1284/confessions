require "rails_helper"

describe PostProcessOrder do
  let!(:service) { PostProcessOrder.build }
  let!(:book) do
    FactoryGirl.create(
      :book,
      content_pdf: File.open(file_fixture("book1.pdf")),
      content_epub: File.open(file_fixture("book1.epub"))
    )
  end
  let!(:product) { FactoryGirl.create(:product, purchasable: book) }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) do
    FactoryGirl.create(:order_item, product: product, order: order)
  end

  it "creates WatermarkedBook for every Book in the order" do
    expect { service.call(order) }.to change { WatermarkedBook.count }.by(1)
  end
end
