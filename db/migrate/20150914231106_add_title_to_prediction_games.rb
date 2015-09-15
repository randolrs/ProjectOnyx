class AddTitleToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :title, :string, :default => ""
    add_column :prediction_games, :body, :text, :default => ""
  end
end
