class Team < ActiveRecord::Base

	attr_accessible :name

	belongs_to :sport
	
end
