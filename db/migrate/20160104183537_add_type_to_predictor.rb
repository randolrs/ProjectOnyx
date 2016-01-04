class AddTypeToPredictor < ActiveRecord::Migration
  def change
    add_column :predictors, :type, :string, :default => ""
  end
end
