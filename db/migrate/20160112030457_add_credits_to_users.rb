class AddCreditsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit_balance, :decimal, precision: 8, scale: 2, default: 0
    add_column :users, :subscription_id, :string, :default => ""
  end
end
