class AddPurchaseTimeToPredictionGamesUsersTable < ActiveRecord::Migration
  def change
    add_column :prediction_games_users, :purchasetime, :time
  end
end
