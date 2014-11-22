class CreatePredictionGames < ActiveRecord::Migration
  def change
    create_table :prediction_games do |t|
      t.string :game_winner
      t.integer :teama_score
      t.integer :teamh_score

      t.timestamps
    end
  end
end
