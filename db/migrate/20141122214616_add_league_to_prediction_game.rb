class AddLeagueToPredictionGame < ActiveRecord::Migration
  def change
    add_column :prediction_games, :league, :string
  end
end
