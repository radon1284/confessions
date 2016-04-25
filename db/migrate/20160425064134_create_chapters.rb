class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :book, index: true, foreign_key: true, null: false
      t.integer :number, null: false
      t.text :content_html, null: false

      t.timestamps null: false
    end
  end
end
