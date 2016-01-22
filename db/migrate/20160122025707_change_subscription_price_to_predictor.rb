class ChangeSubscriptionPriceToPredictor < ActiveRecord::Migration
  def change
  	change_column :predictors, :subscription_price, :decimal, :default => 5
  end
end
