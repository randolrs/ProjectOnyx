class AddGameWinnerToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_winner, :string
  end
end
