class CreatePriceItems < ActiveRecord::Migration
  def change
    create_table :price_items do |t|
      t.string :type, :default => ""
      t.datetime :strike_date
      t.string :strike_description, :default => ""
      t.string :country, :default => ""
      t.decimal :value,      precision: 10, scale: 6, default: 0
      t.string :category, :default => ""

      t.timestamps
    end
  end
end
