class AddEventTypeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :event_type, :string
    add_column :articles, :event_id, :integer
  end
end
