class AddSubCategoryToPredictionEconomies < ActiveRecord::Migration
  def change
    add_column :prediction_economies, :sub_category, :string, :default => ""
  end
end
