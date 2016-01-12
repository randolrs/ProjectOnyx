class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :stripe_id, :default => ""
      t.string :description, :default => ""
      t.decimal :cost, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
