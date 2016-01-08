class AddSubcategoryToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sub_category, :string
  end
end
