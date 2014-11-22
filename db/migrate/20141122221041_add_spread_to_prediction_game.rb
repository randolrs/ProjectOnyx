class AddSpreadToPredictionGame < ActiveRecord::Migration
  def change
    add_column :prediction_games, :spread, :integer
  end
end
