class AddStatusToPredictionEconomies < ActiveRecord::Migration
  def change
    add_column :prediction_economies, :status, :boolean
    add_column :prediction_economies, :onyx, :decimal
    add_column :prediction_economies, :category, :string
  end
end
