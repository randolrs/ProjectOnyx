class ChangeParentTagIdInTopics < ActiveRecord::Migration
	def change
    	change_column :topics, :parent_tag_id, :integer
  	end
end
