class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, default: ""
      t.string :url, default: ""

      t.timestamps
    end
  end
end
