class PredictorsController < ApplicationController

  def findsportspredictors
  	@predictors = Predictor.all

  end

end