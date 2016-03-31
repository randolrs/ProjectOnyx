class PagesController < ApplicationController
  
  def home

    @page = "home"

    @page_title = "Credible Predictions"

    @parent_tag_id = Topic.find_by_name("Home").id.to_s
    
    @featured_topics = Topic.all.where("parent_tag_id = :all_id and id > :home_id", {:all_id => @parent_tag_id, :home_id => 1})

    if TopicCopy.where(:topic_id => 1).present?

      @topic_copy = TopicCopy.find_by_topic_id(1)

    end

    #@featured_topics = Topic.all

    if predictor_signed_in?

      @articles = Article.all.order("created_at DESC")

    else

      staff_recommended = Array.new

      recommendations = Recommendation.all.where(:active => true)

      recommendations.each do |recommendation|

        if Predictor.find(recommendation.user_id).staff

            staff_recommended << Article.find(recommendation.article_id)

          end

      end

      @articles = staff_recommended.sort_by{ |k| k.created_at}.reverse

    end

    @top_articles = @articles.take(5)


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
  
    @predictor = Predictor.find_by_username("Shane Randolph")

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

    @page = "topic_home"

    if @topic

      @page_title = @topic.name + " Predictions & Analysis"

      @articles = @topic.articles.sort_by{ |k| k.created_at}.reverse

      if TopicCopy.where(:topic_id => @topic.id).present?

        @topic_copy = TopicCopy.find_by_topic_id(@topic.id)

      end

      @top_articles = @articles.sort_by{ |k| k.recommendation_count}.reverse.take(5)  

      @child_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id", {:topic_id => @topic.id.to_s, :this_id => @topic.id.to_s})

      if @child_topics.count == 0 and @topic.parent_tag_id > 1

        @parent_topic = Topic.find(@topic.parent_tag_id)

      end

      @related_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id and id > :home_id", {:topic_id => @topic.id.to_s, :this_id => @topic.id.to_s, :home_id => 1})

      if @related_topics.count == 0

        @related_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id and id > :home_id", {:topic_id => @topic.parent_tag_id.to_s, :this_id => @topic.id.to_s, :home_id => 1})

      end

    end

  end

  def topic_top_articles

    @topic = Topic.find_by_url(params[:topic])

    @page = "topic_top"

    if @topic

      @articles = @topic.articles.sort_by{ |k| k.created_at}.reverse

      if TopicCopy.where(:topic_id => @topic.id).present?

        @topic_copy = TopicCopy.find_by_topic_id(@topic.id)

      end

      @top_articles = @articles.sort_by{ |k| k.recommendation_count}.reverse.take(20)  

      @child_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id", {:topic_id => @topic.id.to_s, :this_id => @topic.id.to_s})

      if @child_topics.count == 0 and @topic.parent_tag_id > 1

        @parent_topic = Topic.find(@topic.parent_tag_id)

      end


      @related_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id", {:topic_id => @topic.id.to_s, :this_id => @topic.id.to_s})

      if @related_topics.count == 0

        @related_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id", {:topic_id => @topic.parent_tag_id.to_s, :this_id => @topic.id.to_s})

      end

    end

  end

    def topic_latest_articles

    @topic = Topic.find_by_url(params[:topic])

    @page = "topic_latest"

    if @topic

      @articles = @topic.articles.sort_by{ |k| k.created_at}.reverse

      if TopicCopy.where(:topic_id => @topic.id).present?

        @topic_copy = TopicCopy.find_by_topic_id(@topic.id)

      end

      @top_articles = @articles.sort_by{ |k| k.recommendation_count}.reverse.take(20)  

      @child_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id", {:topic_id => @topic.id.to_s, :this_id => @topic.id.to_s})

      if @child_topics.count == 0 and @topic.parent_tag_id > 1

        @parent_topic = Topic.find(@topic.parent_tag_id)

      end


      @related_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id", {:topic_id => @topic.id.to_s, :this_id => @topic.id.to_s})

      if @related_topics.count == 0

        @related_topics = Topic.all.where("parent_tag_id = :topic_id and id != :this_id", {:topic_id => @topic.parent_tag_id.to_s, :this_id => @topic.id.to_s})

      end

    end

  end

  def top_posts

    @page = "top_posts"
    
    @featured_topics = Topic.all.where("parent_tag_id = :all_id", {:all_id => @parent_tag_id})

    #@top_articles = Article.all #for now

    @article_recommendations = Array.new


    Article.all.each do |article|

      if article.recommendation_count_week > 0

        hash = {:article=> article, :recommendation_count=>article.recommendation_count_week}

        @article_recommendations << hash 

      end

    end

    @top_articles = @article_recommendations.sort_by {|k| k[:recommendation_count]}.reverse

  end


  def bookmarks

    @page = "bookmarks"

    @featured_topics = Topic.all.where("parent_tag_id = :all_id", {:all_id => @parent_tag_id})

    #@featured_topics = Topic.all

    if predictor_signed_in?
      @articles = current_predictor.bookmarked_articles
    end

  end

end
