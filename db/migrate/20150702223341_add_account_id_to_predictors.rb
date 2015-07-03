class AddAccountIdToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :account_id, :string
  end
end
