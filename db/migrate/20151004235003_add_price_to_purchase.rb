class AddPriceToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :price, :decimal, :precision => 8, :scope => 2, :default => 0
  end
end
