class PredictorController < ApplicationController

	def registration
  		new_registration_path(@predictor)
  	end

  	def session
  		new_session_path(@predictor)
  	end

  	def nbapredictors
  		@predictors = Predictor.all.where(Predictor.prediction_games.all.where(:league => "NBA").count => 2)
  	end


end