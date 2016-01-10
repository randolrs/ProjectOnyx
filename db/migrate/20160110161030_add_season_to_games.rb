class AddSeasonToGames < ActiveRecord::Migration
  def change
    add_column :games, :season, :string, :default => ""
  end
end
