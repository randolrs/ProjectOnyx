class PredictorsController < ApplicationController

  def findsportspredictors
  	@predictors = Predictor.all

  end

  def predictionindex

    #params[:username] = params[:username].downcase

    #@predictor = Predictor.find(:first, :conditions => ["lower(username) = ?", params[:username].downcase]) 
    @predictor = Predictor.find_by_username(params[:username])

    if params[:category] 

      if params[:category] = "sports"

        @predictions = @predictor.prediction_games

        if params[:league]

            if params[:league] == "NBA"

              @predictions = @predictor.prediction_games.where(:league => "NBA")

            elsif params[:league] == "NFL"

              @predictions = @predictor.prediction_games.where(:league => "NFL")

            elsif params[:league] == "MLB"

              @predictions = @predictor.prediction_games.where(:league => "MLB")

            elsif params[:league] == "NHL"

              @predictions = @predictor.prediction_games.where(:league => "NHL")

            end
        end
            
          if params[:team_filter]
            #@predictions = @predictions.all.where(:teama => params[:prediction_game][:team])

            @predictions = @predictions.where("teama = :team or teamh = :team", {team: params[:team_filter][:team]})
          end

      elsif params[:category] = "finance"

      elsif params[:category] = "politics"

      elsif params[:category] = "weather"

      end

    else
        @predictions = @predictor.prediction_games

    end

       @predictions = @predictions.order("created_at DESC").paginate(:page =>params[:page], :per_page => 10)

  end

  def articleindex
    @predictor = Predictor.find_by_username(params[:username])
    @articles = @predictor.articles.all.order("created_at DESC")

  end

  def predictordashboard
    @predictor = Predictor.find_by_username(params[:username])
    @predictions = @predictor.prediction_games.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @articles = @predictor.articles.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
  end

end