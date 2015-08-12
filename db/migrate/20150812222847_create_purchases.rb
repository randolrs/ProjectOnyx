class CreatePurchases < ActiveRecord::Migration
	def self.up
	    create_table :purchases do |t|
	    	t.column :user_id, :integer
	    	t.column :predictor_id, :integer
	    	t.column :plan_id, :string
	    	t.column :currency, :string
	    	t.timestamps
	    end
	end

	def self.down
		drop_table :purchases 
	end

end
