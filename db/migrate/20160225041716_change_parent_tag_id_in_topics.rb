class ChangeParentTagIdInTopics < ActiveRecord::Migration
	def change
    	change_column :topics, :parent_tag_id, 'integer USING CAST("parent_tag_id" AS integer)'
  	end
end
