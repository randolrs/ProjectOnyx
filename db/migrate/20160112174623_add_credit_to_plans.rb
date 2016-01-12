class AddCreditToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :credit_per_month, :decimal, precision: 8, scale: 2, default: 0
  end
end
