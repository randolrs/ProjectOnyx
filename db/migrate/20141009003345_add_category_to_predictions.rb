class AddCategoryToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :category, :string
  end
end
