class AddSubCategoryToPriceItems < ActiveRecord::Migration
  def change
    add_column :price_items, :sub_category, :string, :default => ""
  end
end
