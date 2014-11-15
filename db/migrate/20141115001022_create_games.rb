class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :teamh
      t.string :teama

      t.timestamps
    end
  end
end
