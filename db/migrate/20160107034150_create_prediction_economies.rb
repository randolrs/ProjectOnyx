class CreatePredictionEconomies < ActiveRecord::Migration
  def change
    create_table :prediction_economies do |t|
      t.string :type
      t.integer :type_id
      t.datetime :strike_date
      t.string :strike_description
      t.string :country
      t.decimal :value,      precision: 10, scale: 6, default: 0
      t.integer :integer

      t.timestamps
    end
  end
end
