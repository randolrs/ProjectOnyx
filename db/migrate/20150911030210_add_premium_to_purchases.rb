class AddPremiumToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :premium, :boolean
  end
end
