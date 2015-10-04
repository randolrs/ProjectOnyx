class AddRatingToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :rating, :float, :default=> 0
  end
end
