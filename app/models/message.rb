class Message < ActiveRecord::Base

	belongs_to :predictor

	has_many :earnings_predictions
	
	accepts_nested_attributes_for :earnings_predictions, allow_destroy: true#, reject_if: lambda {|attributes| attributes['kind'].blank?}

end
