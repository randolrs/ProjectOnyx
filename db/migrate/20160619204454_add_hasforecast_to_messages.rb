class AddHasforecastToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :has_forecast, :boolean, :default => false
  end
end
