class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.integer :predictor_id
      t.decimal :amount,    precision: 8, scale: 0, default: 0

      t.timestamps
    end
  end
end
