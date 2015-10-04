class PagesController < ApplicationController
  
  def home
  		
      @action = 'home'

      if user_signed_in?

        @displaypredictor = true

        @myPurchases = current_user.my_purchases

        @predictions = current_user.my_prediction_games

        if params[:sort_by]

          if params[:sort_by] == "upcoming"

            @action = "upcoming"
            @predictions = current_user.my_prediction_games_upcoming

          elsif params[:sort_by] == "top"

            @action = "top"
            @predictions = current_user.my_prediction_games_closed.sort_by {|k| k[:prediction].onyx}

          elsif params[:sort_by] == "closed"

            @action = "closed"
            @predictions = current_user.my_prediction_games_closed
          end

        else

          @action = "recent"

        end

      elsif predictor_signed_in?

        @action = 'predictordashboard'
        @predictor = current_predictor
        @username = @predictor.username
        @predictions = @predictor.prediction_games.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
        @displaypredictor = false

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

    @upcominggames = @sport.upcoming_games

    @predictions = @sport.recent_prediction_games

    @top_predictors = @sport.all_predictors.sort_by {|k| k.rating} 

  end

  def league_predictors
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @predictions = PredictionGame.all.where(:league=>@league).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @articles = Article.all.order("created_at DESC").limit(4)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @displaypredictor = true
    @action = "league-home"

    @upcominggames = @sport.upcoming_games

    @subaction = "top"

    @predictors = @sport.all_predictors

  end

  def league_games
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @predictions = PredictionGame.all.where(:league=>@league).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @displaypredictor = true
    @action = "league-home"

    @upcominggames = @sport.upcoming_games

    @subaction = "upcoming"

    @games = @sport.all_games

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
    
    if user_signed_in?
      @predictions = current_user.my_prediction_games
    end

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

  def findexperts
    @expert_type = params[:expert_type]

    @predictorsAll = Predictor.all.order("created_at DESC").limit(10)

    @predictors = Array.new  

    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @predictions = PredictionGame.all.where(:league=>@league).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @articles = Article.all.order("created_at DESC").limit(4)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @displaypredictor = true
    @action = "league-home"    

  end

  def findpredictions
    @prediction_type = params[:prediction_type]

    @predictions = PredictionGame.all.order("created_at DESC").limit(10)
  end

end
