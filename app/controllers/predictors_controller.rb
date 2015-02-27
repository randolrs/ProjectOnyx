class PredictorsController < ApplicationController

  	def nbapredictors

  		@predictors = Predictor.all
  	end




end