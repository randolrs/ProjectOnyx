class AddCategory2ToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :category2, :string
  end
end
