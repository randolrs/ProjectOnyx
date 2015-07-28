class CreatePredictorsUsers < ActiveRecord::Migration
  def self.up
    create_table :predictors_users, :id => false do |t|
    	t.column :predictor_id, :integer
    	t.column :user_id, :integer
    end
  end

  def self.down
  	drop_table :predictors_users

  end
end
