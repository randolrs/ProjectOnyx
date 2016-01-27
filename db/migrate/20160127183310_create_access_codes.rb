class CreateAccessCodes < ActiveRecord::Migration
  def change
    create_table :access_codes do |t|
      t.string :description, default: ""
      t.string :code, default: ""

      t.timestamps
    end
  end
end
