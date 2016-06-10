class EarningsPrediction < ActiveRecord::Base
	belongs_to :predictor
	belongs_to :message
end
