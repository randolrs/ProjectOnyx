class AddEventTimeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :event_time, :datetime
  end
end
