class PagesController < ApplicationController
  def home
  		@action = 'home'
  end

  def about
  end

  def mywatchlist

    if user_signed_in?
      @prediction_games = current_user.prediction_games

    elsif predictor_signed_in?
      @prediction_games = current_predictor.prediction_games

    elsif admin_signed_in?
      @prediction_games = PredictionGame.all
    end

    @prediction_games.each do |prediction_game|
    	prediction_game.update(timetoevent: prediction_game.event_time - Time.now)
    end

  end

  def sportswatchlist
    @prediction_games = PredictionGame.all

    @prediction_games.each do |prediction_game|
      prediction_game.update(timetoevent: prediction_game.event_time - Time.now)
    end

  end

  def nbapredictors
    @predictors = Predictor.all
    params[:league] = "NBA"

  end

  def leaguehome
    @predictions = PredictionGame.all.where(:league=>params[:league]).order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
    @articles = Article.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
    @teams = Team.all.where(:league=>params[:league])
    @games = Game.all.where(:league=>params[:league]).order("event_time DESC").paginate(:page => params[:page], :per_page => 5)

  end

end
