class AddDiffToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :teamh_diff, :integer
    add_column :prediction_games, :teama_diff, :integer
    add_column :prediction_games, :spread_diff, :integer
    add_column :prediction_games, :game_winner_yesno, :boolean
  end
end
