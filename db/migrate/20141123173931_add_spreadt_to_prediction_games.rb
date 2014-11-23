class AddSpreadtToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :spreadt, :integer
    add_column :prediction_games, :game_winnert, :string
  end
end
