class PredictorController < ApplicationController

	def registration
  		new_registration_path(@predictor)
  	end

  	def session
  		new_session_path(@predictor)
  	end




end