class AddAccountToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :account, :boolean, :default => false
  end
end
