class AddPaidToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :paid, :boolean
    add_column :prediction_games, :price, :float
  end
end
