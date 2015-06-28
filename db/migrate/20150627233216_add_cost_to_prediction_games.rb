class AddCostToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :cost, :decimal, :precision => 8, :scale => 2
  end
end
