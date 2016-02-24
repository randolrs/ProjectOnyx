class PagesController < ApplicationController
  
  def home

    @page = "dashboard"

    #@featured_topics = Topic.all.where("parent_tag_id = :all_id", {all_id: => 1})

    @featured_topics = Topic.all

    @articles = Article.all.order("created_at DESC")

    @top_articles = @articles.limit(5)


    if user_signed_in?

      @displaypredictor = true

      @myPurchases = current_user.my_purchases

      @predictors = current_user.my_predictors

      @predictions = current_user.my_prediction_games

      @predictor_subscriptions = current_user.my_subscriptions

      @upcominggames = Game.all.where("event_time > :time_now", {time_now: Time.now}).order("event_time ASC").limit(3)

    elsif predictor_signed_in?

      @predictor = current_predictor

      @followers_count = @predictor.purchases.count
      @subscriptions_count = @predictor.purchases.all.where(:premium => true).count
      @current_balance = 0

    end

  end

  def dashboard
      
    @page = "dashboard"

    if user_signed_in?

      @displaypredictor = true

      @myPurchases = current_user.my_purchases

      @predictions = current_user.my_prediction_games

      @upcominggames = Game.all.where("event_time > :time_now", {time_now: Time.now}).order("event_time ASC").limit(3)

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
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @displaypredictor = true
    @action = "league-home"

    @upcominggames = @sport.upcoming_games.take(3) 

    @predictions = @sport.recent_prediction_games

    @predictors = @sport.all_predictors.sort_by {|k| k.rating}

    @top_predictors = @sport.all_predictors.sort_by {|k| k.rating}.take(3) 

  end

  def league_predictors
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").limit(4)
    @displaypredictor = true
    @action = "league-home"

    @upcominggames = @sport.upcoming_games.take(3) 

    @subaction = "top"

    @top_predictors = @sport.all_predictors.sort_by {|k| k.rating}.take(3)

    @predictors = @sport.all_predictors.sort_by {|k| k.rating}

  end

  def league_games
    @league = params[:league]
    @sport = Sport.find_by_subcat(@league)
    @predictions = PredictionGame.all.where(:league=>@league).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC")
    @displaypredictor = true
    @action = "league-home"

    @upcominggames = @sport.upcoming_games.take(3) 

    @subaction = "upcoming"

    @top_predictors = @sport.all_predictors.sort_by {|k| k.rating}.take(3)

    @games = @sport.all_games

    @today = Time.now.beginning_of_day
    @tomorrow = Time.now.tomorrow.beginning_of_day
    @tomorrowsq = @tomorrow.tomorrow.beginning_of_day

    @games_today = Game.where(event_time: @today..@today.end_of_day, league: @league)
    @games_tomorrow = Game.where(event_time: @tomorrow..@tomorrow.end_of_day, league: @league)
    @games_tomorrowsq = Game.where(event_time: @tomorrowsq.beginning_of_day..@tomorrowsq.end_of_day, league: @league)

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

  def user_index
    if admin_signed_in?

      @users = User.all

    else

      redirect_to root_path
    end
  end

  def tag_show

    @tag = Tag.find_by_url(params[:tag])
    @articles = Article.all

  end

  def topic_show

    @topic = Topic.find_by_url(params[:topic])
    @articles = Article.all

  end

end
