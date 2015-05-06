class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
