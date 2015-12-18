class AddActiveToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :active, :boolean
  end
end
