class AddMessageidToEarningsPredictions < ActiveRecord::Migration
  def change
    add_column :earnings_predictions, :message_id, :integer
  end
end
