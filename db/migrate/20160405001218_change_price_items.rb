class ChangePriceItems < ActiveRecord::Migration
  def change
  	change_column :price_items, :value, :decimal, precision: 10, scale: 6, default: nil
  end
end
