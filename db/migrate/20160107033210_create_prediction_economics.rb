class CreatePredictionEconomics < ActiveRecord::Migration
  def change
    create_table :prediction_economics do |t|
      t.string :type
      t.string :country
      t.datetime :strike_date
      t.string :strike_date_descriptor
      t.decimal :value,       precision: 10, scale: 6, default: 0

      t.timestamps
    end
  end
end
