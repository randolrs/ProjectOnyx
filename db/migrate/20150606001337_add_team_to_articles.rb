class AddTeamToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :teama, :string
    add_column :articles, :teamh, :string
  end
end
