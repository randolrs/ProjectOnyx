class PredictorsController < ApplicationController

  def nbapredictors
    @predictors = Predictor.all
    params[:league] = "NBA"
  end

  def nflpredictors
    @predictors = Predictor.all
    params[:league] = "NFL"
  end

  def mlbpredictors
    @predictors = Predictor.all
    params[:league] = "MLB"
  end

  def nhlpredictors
    @predictors = Predictor.all
    params[:league] = "NHL"
  end




end