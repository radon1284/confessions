class PostProcessOrder
  def self.build
    new(DI.get(CreateWatermarkedBook))
  end

  def initialize(create_watermarked_book)
    self.create_watermarked_book = create_watermarked_book
  end

  def call(order)
    order.books.each do |book|
      create_watermarked_book.call(book, order)
    end
  end

  private

  attr_accessor :create_watermarked_book
end
