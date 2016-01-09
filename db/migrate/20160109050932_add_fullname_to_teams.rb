class AddFullnameToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :full_name, :string, :default => ""
  end
end
