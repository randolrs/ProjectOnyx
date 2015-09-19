class AddOverunderToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :overunder, :integer, :default => 0
  end
end
