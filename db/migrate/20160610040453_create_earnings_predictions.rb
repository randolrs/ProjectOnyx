class CreateEarningsPredictions < ActiveRecord::Migration
  def change
    create_table :earnings_predictions do |t|
      t.integer :company_id
      t.string :company
      t.string :ticker
      t.decimal :eps_estimate
      t.string :quarter
      t.string :year
      t.string :status
      t.decimal :eps_actual
      t.decimal :rating

      t.timestamps
    end
  end
end
