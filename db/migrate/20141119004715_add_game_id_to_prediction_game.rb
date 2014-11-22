class AddGameIdToPredictionGame < ActiveRecord::Migration
  def change
    add_column :prediction_games, :game_id, :integer
    add_index :prediction_games, :game_id
  end
end
