class ChangeParentTagIdInTopics < ActiveRecord::Migration
	def change
    	connection.execute(%q{
    		alter table topics
    		alter column parent_tag_id
    		type integer using cast(number as integer)
  			})
  	end
end
