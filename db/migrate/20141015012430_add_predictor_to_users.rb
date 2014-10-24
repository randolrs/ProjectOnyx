class AddPredictorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :predictor, :boolean, :default => false
  end

  def self.down
    remove_column :users, :predictor
  end
end
