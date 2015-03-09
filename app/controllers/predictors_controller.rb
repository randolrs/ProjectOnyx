class PredictorsController < ApplicationController

  
	end

  def findsportspredictors
  	@predictors = Predictor.all

  end

end