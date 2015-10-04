class AddPriceToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :subscription_price, :decimal, :precision => 8, :scope => 2, :default => 0
  end
end
