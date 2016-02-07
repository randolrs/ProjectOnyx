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
  end

  # GET /articles/new
  def new
    @article = Article.new

    @predictor = current_predictor

    # @game = Game.find(params[:game])

    # @league = @game.league

    # @teama = Team.find_by_name(@game.teama)
    # @teamh = Team.find_by_name(@game.teamh)

    # @prediction_game = @article.prediction_games.build 

    # @prediction_game.game_id = @game.id

    # @prediction_game.predictor_id = @predictor.id

    # @prediction_game.teama = @game.teama

    # @prediction_game.teamh = @game.teamh

    # @prediction_game.league = @game.league

    # @prediction_game.event_time = @game.event_time

    # @prediction_game.status = "o"

    # @prediction_game.league = @game.league

    # @article.event_id = @game.id
    # @article.event_time = @game.event_time
    # @article.teama = @teama.name
    # @article.teamh = @teamh.name

    respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @article }
    end

  end

  # GET /articles/1/edit
  def edit
  end

  def ajax_league
    
    if params[:game]
    
      @game = Game.find(params[:game])
      @team_away = Team.find(@game.teama_id)
      @team_home = Team.find(@game.teamh_id)

      respond_to do |format|
        format.js { render json: { :teama => @team_away.name, :teamh => @team_home.name, :game_id => @game.id } , content_type: 'text/json' }
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
        prediction_game.update(:predictor_id => current_predictor.id)
        game = Game.find(prediction_game.game_id)
        prediction_game.update(:league => game.league)
        prediction_game.update(:event_time => game.event_time)
      end

      respond_to do |format|
        if @article.save

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

          format.html { redirect_to @article, notice: 'Article was successfully created.' }
          format.json { render :show, status: :created, location: @article }

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
      params.require(:article).permit(:title, :body, :hits, :event_id, :event_type, :event_time, :teama, :teamh, prediction_games_attributes:[:game_winner, :teama_score, :teamh_score, :spread, :game_id, :event_time, :status, :teama, :teamh, :league, :article_id, :predictor_id, :cost])
    end
end
