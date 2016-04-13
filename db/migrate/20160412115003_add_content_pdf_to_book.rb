class AddContentPdfToBook < ActiveRecord::Migration
  def change
    add_column :books, :content_pdf, :text
  end
end
