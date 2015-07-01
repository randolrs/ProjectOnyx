class AddDefaultToUser < ActiveRecord::Migration
 
  	def up
  		change_column :users, :balance, :decimal, :default => 0
  		change_column :predictors, :balance, :decimal, :default => 0
	end

	def down
  		change_column :users, :balance, :decimal, default: nil
  		change_column :predictors, :balance, :decimal, default: nil
	end

end
