class AddTeamaIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :teama_id, :integer
  end
end
