class AddPdfPreviewContentToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :content_pdf_preview, :text
  end
end
