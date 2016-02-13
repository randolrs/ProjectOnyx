class AddCategoryToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :category, :string, default: ""
  end
end
