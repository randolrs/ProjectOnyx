class AddTeamascoreToGames < ActiveRecord::Migration
  def change
    add_column :games, :teama_score, :integer
    add_column :games, :teamh_score, :integer
    add_column :games, :score_spread, :integer
  end
end
