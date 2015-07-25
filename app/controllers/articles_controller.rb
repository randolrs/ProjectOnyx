class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
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

    for prediction_game in @article.prediction_games
      @prediction_game = prediction_game
    end

    @league = @prediction_game.league
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)
    @game = Game.find(@article.event_id)
    @teama = Team.find_by_name(@game.teama)
    @teamh = Team.find_by_name(@game.teamh)

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

    @game = Game.find(params[:game])

    @league = @game.league

    @teama = Team.find_by_name(@game.teama)
    @teamh = Team.find_by_name(@game.teamh)

    @prediction_game = @article.prediction_games.build 

    @prediction_game.game_id = @game.id

    @prediction_game.predictor_id = @predictor.id

    @prediction_game.teama = @game.teama

    @prediction_game.teamh = @game.teamh

    @prediction_game.league = @game.league

    @prediction_game.event_time = @game.event_time

    @prediction_game.status = "o"

    @prediction_game.league = @game.league

    @article.event_id = @game.id
    @article.event_time = @game.event_time
    @article.teama = @teama.name
    @article.teamh = @teamh.name

    respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @article }
    end

  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.predictor_id = current_predictor.id
    @article.hits = 0

    @game = Game.find(@article.event_id)

    for prediction_game in @article.prediction_games
      prediction_game.predictor_id = current_predictor.id
      prediction_game.game_id = @article.event_id
      prediction_game.event_time = @article.event_time
      prediction_game.teama = @game.teama
      prediction_game.teamh = @game.teamh
      if Time.now > prediction_game.event_time
        prediction_game.status = "o"
      end

      prediction_game.league = @game.league

      if prediction_game.teama_score > prediction_game.teamh_score
        prediction_game.game_winner = prediction_game.teama
        prediction_game.spread = prediction_game.teama_score - prediction_game.teamh_score
      elsif prediction_game.teama_score < prediction_game.teamh_score
        prediction_game.game_winner = prediction_game.teamh
        prediction_game.spread = prediction_game.teamh_score - prediction_game.teama_score
      elsif prediction_game.teama_score == prediction_game.teamh_score
        prediction_game.game_winner = "N/A"
        prediction_game.spread = 0
      end

    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }

      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
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
