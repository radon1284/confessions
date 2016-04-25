class AddUniqueIndexToChapter < ActiveRecord::Migration
  def change
    add_index :chapters, [:book_id, :number], unique: true
  end
end
