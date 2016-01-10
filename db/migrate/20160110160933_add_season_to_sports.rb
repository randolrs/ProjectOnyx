class AddSeasonToSports < ActiveRecord::Migration
  def change
    add_column :sports, :current_season, :string, :default => ""
  end
end
