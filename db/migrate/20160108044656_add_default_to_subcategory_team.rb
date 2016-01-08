class AddDefaultToSubcategoryTeam < ActiveRecord::Migration
  def change
  	change_column :teams, :sub_category, :string, :default => ""
  end
end
