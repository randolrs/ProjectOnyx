class AddAccountTokenToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :account_token, :string
  end
end
