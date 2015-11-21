class AddSubscriptioncountToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :subscription_count, :integer
  end
end
