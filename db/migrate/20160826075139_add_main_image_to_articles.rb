class AddMainImageToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :main_image, :string
  end
end
