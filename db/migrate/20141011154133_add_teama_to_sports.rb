class AddTeamaToSports < ActiveRecord::Migration
  def change
    add_column :sports, :TeamA, :string
    add_column :sports, :TeamB, :string
  end
end
