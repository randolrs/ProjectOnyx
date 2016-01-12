class AddCreditToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :credit_balance, :decimal, precision: 8, scale: 2, default: 0
  end
end
