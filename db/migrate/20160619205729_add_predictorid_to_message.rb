class AddPredictoridToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :predictor_id, :integer
  end
end
