class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.string :event

      t.timestamps
    end
  end
end
