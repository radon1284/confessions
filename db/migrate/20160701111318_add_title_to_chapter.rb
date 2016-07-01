class AddTitleToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :title, :text
  end
end
