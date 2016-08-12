class CreateWatermarkedBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :watermarked_books do |t|
      t.references :order, foreign_key: true, type: :uuid
      t.references :book, foreign_key: true
      t.text :content_pdf
      t.text :content_epub
      t.text :content_mobi

      t.timestamps
    end
  end
end
