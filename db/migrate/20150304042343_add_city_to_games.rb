class AddCityToGames < ActiveRecord::Migration
  def change
    add_column :games, :event_city, :string
    add_column :games, :event_venue, :string
  end
end
