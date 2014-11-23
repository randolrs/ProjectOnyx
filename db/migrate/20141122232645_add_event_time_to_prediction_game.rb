class AddEventTimeToPredictionGame < ActiveRecord::Migration
  def change
    add_column :prediction_games, :event_time, :datetime
  end
end
