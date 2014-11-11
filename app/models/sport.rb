class Sport < ActiveRecord::Base

	attr_accessible :subcat

	has_many :teams
end
