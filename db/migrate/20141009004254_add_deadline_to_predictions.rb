class AddDeadlineToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :deadline, :time
  end
end
