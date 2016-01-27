class AddAccesscodeToPredictors < ActiveRecord::Migration
  def change
    add_column :predictors, :access_code, :string, default: ""
  end
end
