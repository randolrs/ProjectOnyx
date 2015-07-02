class AddBioToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :bio, :text, :limit => 250
  end
end
