class AddTeamhIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :teamh_id, :integer
  end
end
