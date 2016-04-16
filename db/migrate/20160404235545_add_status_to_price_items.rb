class AddStatusToPriceItems < ActiveRecord::Migration
  def change
    add_column :price_items, :status, :boolean
    add_column :price_items, :description, :string
  end
end
