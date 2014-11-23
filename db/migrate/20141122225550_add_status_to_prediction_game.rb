class AddStatusToPredictionGame < ActiveRecord::Migration
  def change
    add_column :prediction_games, :status, :string
  end
end
