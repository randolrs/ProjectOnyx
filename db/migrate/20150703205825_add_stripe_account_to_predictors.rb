class AddStripeAccountToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :stripe_account_id, :string
  end
end
