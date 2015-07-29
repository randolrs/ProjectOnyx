class AddSubscriptionIdToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :subscription_id, :string
  end
end
