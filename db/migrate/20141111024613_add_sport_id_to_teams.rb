class AddSportIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sport_id, :integer
    add_index :teams, :sport_id
  end
end
