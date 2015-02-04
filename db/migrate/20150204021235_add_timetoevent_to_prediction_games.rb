class AddTimetoeventToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :timetoevent, :time
  end
end
