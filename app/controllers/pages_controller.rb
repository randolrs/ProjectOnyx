class PagesController < ApplicationController
  def home
  		@action = 'home'

      if user_signed_in?

       @action = "recent"

      @displaypredictor = true

      #need to add logic for sorted array that includes both premium and non premium predictions

      @myPurchases = Purchase.all.where(:user_id => current_user.id)

      @predictions = Array.new 

      unless @myPurchases.count == 0

        @myPurchases.each do |myPurchase|

        @predictor = Predictor.find(myPurchase.predictor_id)

        @predictor.prediction_games.each do |prediction_game|

        hash = {:prediction=>prediction_game, :premium_access=> myPurchase.premium}

        @predictions << hash

        #@predictions << prediction_game

        #@predictor.prediction_games.each do |prediction_game|

          #unless prediction_game.paid
            #@predictions << prediction_game
          #end

        #end
            
          end
        end

      end
      end

      if predictor_signed_in?

        @action = 'predictordashboard'
        @predictor = current_predictor
        @username = @predictor.username
        @predictions = @predictor.prediction_games.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
        @articles = @predictor.articles.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
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

  def findexperts
    @expert_type = params[:expert_type]

    @predictorsAll = Predictor.all.order("created_at DESC").limit(10)

    @predictors = Array.new 

      @predictorsAll.each do |predictor|

        #Need to add hash logic for premium verus non-premium

        hash = {:username=>predictor.username, :image => predictor.image, :prediction_count => predictor.prediction_games.where(:status=>"o").all.count}

        # if myPurchase.premium == true

        #     @predictors << @predictor

        # else

        #     @predictors << @predictor

        # end

        @predictors << hash  

      end        

  end

  def findpredictions
    @prediction_type = params[:prediction_type]

    @predictions = PredictionGame.all.order("created_at DESC").limit(10)
  end

end
