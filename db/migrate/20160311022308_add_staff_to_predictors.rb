class AddStaffToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :staff, :boolean, default: false
  end
end
