class AddTeamaTscoreToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :teama_tscore, :integer
    add_column :prediction_games, :teamh_tscore, :integer
  end
end
