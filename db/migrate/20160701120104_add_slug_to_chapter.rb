class AddSlugToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :slug, :text
  end
end
