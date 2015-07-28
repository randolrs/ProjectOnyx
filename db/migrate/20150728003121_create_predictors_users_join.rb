class CreatePredictorsUsersJoin < ActiveRecord::Migration

   def self.up
    create_table :predictors_users_join, :id => false do |t|
    	t.column :predictor_id, :integer
    	t.column :user_id, :integer
    end
  end

  def self.down
  	drop_table :predictors_users_join

  end
end
