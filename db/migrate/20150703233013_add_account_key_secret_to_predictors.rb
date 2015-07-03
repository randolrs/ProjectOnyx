class AddAccountKeySecretToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :account_key_secret, :string
  end
end
