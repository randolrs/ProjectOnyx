class AddPremiumToPredictorsUsers < ActiveRecord::Migration
  def change
    add_column :predictors_users, :premium, :boolean
  end
end
