class AddOuDiffToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :ou_diff, :float
  end
end
