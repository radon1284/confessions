class AddContentEpubAndContentMobiToBook < ActiveRecord::Migration
  def change
    add_column :books, :content_epub, :text
    add_column :books, :content_mobi, :text
  end
end
