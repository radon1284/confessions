class CreateWatermarkedBook
  def self.build
    new(
      DI.get(GenerateWatermarkedPDF),
      DI.get(GenerateWatermarkedEPUB),
      DI.get(GenerateWatermarkedMOBI)
    )
  end

  def initialize(
    generate_watermarked_pdf,
    generate_watermarked_epub,
    generate_watermarked_mobi
  )
    self.generate_watermarked_pdf = generate_watermarked_pdf
    self.generate_watermarked_epub = generate_watermarked_epub
    self.generate_watermarked_mobi = generate_watermarked_mobi
  end

  def call(book, order)
    email = order.user.email
    WatermarkedBook.create!(
      order: order,
      book: book,
      content_pdf: pdf(book, email),
      content_epub: epub(book, email),
      content_mobi: mobi(book, email)
    )
  end

  private

  attr_accessor :generate_watermarked_pdf
  attr_accessor :generate_watermarked_epub
  attr_accessor :generate_watermarked_mobi

  def pdf(book, email)
    InMemoryFile.new(
      generate_watermarked_pdf.call(book.content_pdf, email),
      "book.pdf"
    )
  end

  def epub(book, email)
    InMemoryFile.new(
      generate_watermarked_epub.call(book.content_epub, email),
      "book.epub"
    )
  end

  def mobi(book, email)
    InMemoryFile.new(
      generate_watermarked_mobi.call(book.content_epub, email),
      "boook.mobi"
    )
  end
end
