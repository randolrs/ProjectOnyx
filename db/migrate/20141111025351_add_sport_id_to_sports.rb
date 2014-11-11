class AddSportIdToSports < ActiveRecord::Migration
  def change
    add_column :sports, :sport_id, :string
    add_index :sports, :sport_id
  end
end
