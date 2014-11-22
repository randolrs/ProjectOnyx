class AddGameIdToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :game_id, :integer
    add_index :predictions, :game_id
  end
end
