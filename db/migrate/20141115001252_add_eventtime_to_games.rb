class AddEventtimeToGames < ActiveRecord::Migration
  def change
    add_column :games, :event_time, :datetime
  end
end
