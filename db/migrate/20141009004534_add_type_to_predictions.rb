class AddTypeToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :type, :string
  end
end
