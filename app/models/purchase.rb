class Purchase < ActiveRecord::Base

	belongs_to :predictor
	belongs_to :user

end
