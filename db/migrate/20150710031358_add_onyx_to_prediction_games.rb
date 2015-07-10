class AddOnyxToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :onyx, :float
  end
end
