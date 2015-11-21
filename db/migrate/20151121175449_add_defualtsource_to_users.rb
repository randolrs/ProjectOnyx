class AddDefualtsourceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_source, :string
  end
end
