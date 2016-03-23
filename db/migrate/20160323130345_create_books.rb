class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :slug
      t.index :slug, unique: true

      t.timestamps null: false
    end
  end
end
