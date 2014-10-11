class AddPrecictorToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :predictor_id, :integer
  end
end
