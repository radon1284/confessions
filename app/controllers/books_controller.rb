class BooksController < ApplicationController
  def index
    books = Book.all
    render(
      locals: {
        books: books
      }
    )
  end

  def show
    book = Book.find_by!(slug: params.fetch(:id))
    chapters = book.chapters.order(:number)
    render(
      locals: {
        book: book,
        chapters: chapters
      }
    )
  end

  def download_pdf
    order = Order.find(params.fetch(:order_id))
    book = order.books.find(params.fetch(:id))

    send_data(
      watermarked_pdf_content(book, order),
      filename: "book.pdf",
      type: "application/pdf"
    )
  end

  def download_epub
    order = Order.find(params.fetch(:order_id))
    book = order.books.find(params.fetch(:id))

    send_data(
      watermarked_epub_content(book, order),
      filename: "book.epub",
      type: "application/epub+zip"
    )
  end

  def download_mobi
    order = Order.find(params.fetch(:order_id))
    book = order.books.find(params.fetch(:id))

    send_data(
      watermarked_mobi_content(book, order),
      filename: "book.mobi",
      type: "application/x-mobipocket-ebook"
    )
  end

  private

  def watermarked_pdf_content(book, order)
    DI.get(GenerateWatermarkedPDF)
      .call(book.content_pdf, order.user.email)
  end

  def watermarked_epub_content(book, order)
    DI.get(GenerateWatermarkedEPUB)
      .call(book.content_epub, order.user.email)
  end

  def watermarked_mobi_content(book, order)
    DI.get(GenerateWatermarkedMOBI)
      .call(book.content_epub, order.user.email)
  end
end
