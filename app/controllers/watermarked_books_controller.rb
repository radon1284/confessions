class WatermarkedBooksController < ApplicationController
  def download_pdf
    watermarked_book = find_watermarked_book_by_order
    redirect_to watermarked_book.content_pdf.download_url
  end

  def download_epub
    watermarked_book = find_watermarked_book_by_order
    redirect_to watermarked_book.content_epub.download_url
  end

  def download_mobi
    watermarked_book = find_watermarked_book_by_order
    redirect_to watermarked_book.content_mobi.download_url
  end

  private

  def find_watermarked_book_by_order
    order = Order.find(params.fetch(:order_id))
    order.watermarked_books.find(params.fetch(:id))
  end
end
