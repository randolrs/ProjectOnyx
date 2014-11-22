class AddPredictorIdToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :predictor_id, :integer
    add_index :prediction_games, :predictor_id
  end
end
