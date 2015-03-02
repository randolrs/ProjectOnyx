class CreatePredictionGamesUsersTable < ActiveRecord::Migration
  def change
    create_table :prediction_games_users, id: false do |t|
      t.string :user_id
      t.integer :prediction_game_id
    end

    add_index :prediction_games_users, :user_id
    add_index :prediction_games_users, :prediction_game_id
  end
end
