class AddPublishedToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :published, :boolean, default: false, null: false
    Article.reset_column_information
    Article.all.each do |article|
      article.published = true
      article.save
    end
  end
end
