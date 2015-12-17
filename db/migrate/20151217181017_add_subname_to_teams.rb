class AddSubnameToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sub_name, :string
  end
end
