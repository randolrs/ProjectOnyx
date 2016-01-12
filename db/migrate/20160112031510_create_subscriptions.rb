class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_id, :string, :default => ""
      t.string :description, :string, :default => ""
      t.decimal :cost, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
