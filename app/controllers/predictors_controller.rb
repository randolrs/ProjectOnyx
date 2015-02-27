class PredictorsController < ApplicationController

  def nbapredictors
    @predictors = Predictor.all
    params[:league] = "NBA"

	if params[:predictor]

		if params[:predictor][:sort_param]

			if params[:predictor][:sort_param] == "Rating (League)"

				#@predictors = @predictors.sort_by(&:created_at).reverse

			elsif params[:predictor][:sort_param] == "Rating (Overall)"

				#@predictors = @predictors.sort_by(&:created_at)

			elsif params[:predictor][:sort_param] == "# of Predictions"

				#@predictors = @predictors.sort_by(&:created_at)

			elsif params[:predictor][:sort_param] == "Date Joined"

				@predictors = @predictors.sort_by(&:created_at)

			elsif params[:predictor][:sort_param] == "Subscription Price"

	          	#@predictors = @predictors.sort_by(&:created_at)

	        end
    	end
    end
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