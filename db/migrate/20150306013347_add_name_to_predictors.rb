class AddNameToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :name, :string
    add_column :predictors, :username, :string
    add_column :predictors, :balance, :decimal
  end
end
