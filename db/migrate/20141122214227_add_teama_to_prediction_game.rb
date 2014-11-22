class AddTeamaToPredictionGame < ActiveRecord::Migration
  def change
    add_column :prediction_games, :teama, :string
    add_column :prediction_games, :teamh, :string
  end
end
