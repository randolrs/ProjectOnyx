class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index

    if predictor_signed_in?

    elsif user_signed_in?

      @action = "posts"

      @displaypredictor = true

      @predictors = current_user.predictors.collect

      @articles = Array.new 

      if @predictors.count > 0

        @predictors.each do |predictor|

          if predictor.articles.count > 0
            predictor.articles.each do |article|

              @articles << article

            end
          end

        end

      end

      #@predictions.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)


    end
    
  end

  def articleindex
    @predictor = Predictor.where(:username=>params[:username])
    @articles = @predictor.articles
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    
    @article = Article.find(params[:id])
    @article.update(hits: @article.hits+1)
    @predictor = Predictor.find(@article.predictor_id)

    if user_signed_in?
      @usertype = "user"
      @access = current_user
    elsif predictor_signed_in?
      @usertype = "predictor"
      @access = current_predictor
    elsif admin_signed_in?
      @usertype = "admin"
    else
      @usertype = "none"
    end

    @predictor_other_articles = Article.where(:predictor_id => @predictor.id).where.not(:id => @article.id).order(created_at: :desc).take(3)
  end

  # GET /articles/new
  def new
    @article = Article.new

    @predictor = current_predictor

    respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @article }
    end

  end

  # GET /articles/1/edit
  def edit
  

  end

  def ajax_team

    if params[:team]

      @team = Team.find(params[:team])

      respond_to do |format|
        format.js { render json: { :team_id => "test-holder" } , content_type: 'text/json' }
      end

    end

  end

  def ajax_league
    
    if params[:game]
    
      @game = Game.find(params[:game])
      @team_away = Team.find(@game.teama_id)
      @team_home = Team.find(@game.teamh_id)

      respond_to do |format|
        format.js { render json: { :teama => @team_away.name, :teamh => @team_home.name, :game_id => @game.id, :event_time => @game.event_time, :league => @game.league } , content_type: 'text/json' }
      end

    end

  end

  def ajax_recommend

    # if predictor_signed_in?

      if params[:article_id]

        @article_object = Article.find(params[:article_id])

        unless current_predictor.has_recommendation_active(@article_object.id)

           unless current_predictor.has_recommendation_inactive(@article_object.id)

            @recommendation = Recommendation.new

            @recommendation.update(:article_id => @article_object.id, :user_id =>current_predictor.id)

            @recommendation.save

          else

            @recommendation = Recommendation.where(:article_id => @article_object.id, :user_id =>current_predictor.id).first

            @recommendation.update(:active => true)

           end

          respond_to do |format|
            format.js { render json: { :now_recommending => true } , content_type: 'text/json' }
          end

        else

           @recommendation = Recommendation.where(:article_id => @article_object.id, :user_id =>current_predictor.id).first

           @recommendation.update(:active => false)

          respond_to do |format|
            format.js { render json: { :now_recommending => false } , content_type: 'text/json' }
          end

    #     end

        end

    end

  end

  def ajax_bookmark

    # if predictor_signed_in?

      if params[:article_id]

        @article_object = Article.find(params[:article_id])

        unless current_predictor.has_bookmark_active(@article_object.id)

           unless current_predictor.has_bookmark_inactive(@article_object.id)

            @bookmark = Bookmark.new

            @bookmark.update(:article_id => @article_object.id, :user_id =>current_predictor.id)

            @bookmark.save

          else

            @bookmark = Bookmark.where(:article_id => @article_object.id, :user_id =>current_predictor.id).first

            @bookmark.update(:active => true)

           end

          respond_to do |format|
            format.js { render json: { :now_bookmarked => true } , content_type: 'text/json' }
          end

        else

           @bookmark = Bookmark.where(:article_id => @article_object.id, :user_id =>current_predictor.id).first

           @bookmark.update(:active => false)

          respond_to do |format|
            format.js { render json: { :now_bookmarked => false } , content_type: 'text/json' }
          end

        end

    end

  end

  # POST /articles
  # POST /articles.json
  def create

    if predictor_signed_in?

      @article = Article.new(article_params)
      @article.predictor_id = current_predictor.id
      @article.hits = 0

      @article.prediction_games.each do |prediction_game|
        
        if prediction_game.game_id.nil?
            prediction_game.destroy
        else
          prediction_game.update(:predictor_id => current_predictor.id)
          game = Game.find(prediction_game.game_id)
          prediction_game.update(:league => game.league)
          overunder = prediction_game.teama_score + prediction_game.teamh_score
          prediction_game.update(:overunder => overunder)
          #prediction_game.update(:article_id => @article.id)
              
          if prediction_game.teama_score > prediction_game.teamh_score
            prediction_game.update(:game_winner => prediction_game.teama)
            prediction_game.update(:spread => prediction_game.teama_score - prediction_game.teamh_score)

          elsif prediction_game.teama_score < prediction_game.teamh_score
            prediction_game.update(:game_winner => prediction_game.teamh)
            prediction_game.update(:spread => prediction_game.teamh_score - prediction_game.teama_score)

          end

          prediction_game.update(:event_time => game.event_time)
          
        end

      end

      respond_to do |format|
        if @article.save

          if @article.prediction_games.count > 0

            @tagging = Tagging.new

            @tagging.update(:article_id => @article.id)

            @tagging.update(:tag_id => Topic.find_by_name("Sports").id)

            @article.prediction_games.each do |prediction_game|

              @game_league_tag_id = Topic.find_by_name(prediction_game.league).id

              unless @game_league_tag_id.nil?

                unless @article.has_topic(@article.id, @game_league_tag_id)

                  @tagging = Tagging.new

                  @tagging.update(:article_id => @article.id)

                  @tagging.update(:tag_id => @game_league_tag_id)

                end

              end
              
            end

          end

          unless current_predictor.account ###make this check a partial

            Stripe.api_key = Rails.configuration.stripe[:secret_key]
            account = Stripe::Account.create(
              {:country => "US", :managed => true, :email => current_predictor.email, :transfer_schedule["interval"] => "manual"}
            )

            current_predictor.update(:account => true)
            current_predictor.update(:account_id => account.id)
            current_predictor.update(:account_token => account.keys.publishable)
            current_predictor.update(:account_key_secret => account.keys.secret)

          end

          unless current_predictor.subscription_id

            Stripe.api_key = Rails.configuration.stripe[:secret_key]
            #Stripe.api_key = @predictor.account_key_secret

            plan = Stripe::Plan.create(
              :amount => 500,
              :interval => 'month',
              :name => "Subscription for " + current_predictor.username.humanize,
              :currency => 'usd',
              :id => current_predictor.username + "sub" + current_predictor.id.to_s,
            )

            current_predictor.update(:subscription_id => plan.id)

          end

          format.html { redirect_to predictorarticleshow_path(current_predictor.username, @article.id), notice: 'Article was successfully published.' }

        else

          format.html { render :new }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:id, :title, :body, :hits, :event_id, :event_type, :event_time, :category, :teama, :teamh, prediction_games_attributes:[:game_winner, :teama_score, :teamh_score, :spread, :game_id, :event_time, :status, :teama, :teamh, :league, :article_id, :predictor_id, :cost])
    end
end
