class PagesController < ApplicationController
  def home
  		@action = 'home'

      if user_signed_in?

        @action = "recent"

        @displaypredictor = true

        @predictors = current_user.predictors.collect

        @predictions = Array.new 

        if @predictors.count > 0

          @predictors.each do |predictor|

            predictor.prediction_games.each do |prediction_game|

              @predictions << prediction_game

            end
          end
        end
      end

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
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @predictions = PredictionGame.all.where(:league=>@league).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @articles = Article.all.order("created_at DESC").limit(4)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @displaypredictor = true
    @action = "league-home"

  end

  def leaguearticleindex
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @articles = Article.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @action = "posts"

  end

  def leaguepredictionindex
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @predictions = PredictionGame.all.where(:league=>@league).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @displaypredictor = true
    @action = "predictions"

  end

  def leaguegameindex
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def gamepredictionindex
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @game = Game.find(params[:id])
    @predictions = PredictionGame.all.where(:game_id=>@game.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)    
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @teama = Team.find_by_name(@game.teama)
    @teamh = Team.find_by_name(@game.teamh)
    @displaypredictor = true
    @matchup_hide = true
  end

  def gamearticleindex
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @game = Game.find(params[:id])
    @articles = Article.all.where(:event_id=>@game.id).paginate(:page => params[:page], :per_page => 10)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @teama = Team.find_by_name(@game.teama)
    @teamh = Team.find_by_name(@game.teamh)
  end

end
