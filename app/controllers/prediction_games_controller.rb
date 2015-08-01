class PredictionGamesController < ApplicationController
  before_action :set_prediction_game, only: [:show, :edit, :update, :destroy]

  # GET /prediction_games
  # GET /prediction_games.json
  
  def index
    
    if predictor_signed_in?

    elsif user_signed_in?

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

      #@predictions.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)


    end

  end


  def index_closed
    @prediction_games = PredictionGame.all
  end

  # GET /prediction_games/1
  # GET /prediction_games/1.json
  def show
    @prediction_game = PredictionGame.find(params[:id])
    @game = Game.find(@prediction_game.game_id)
    @predictor = Predictor.find(@prediction_game.predictor_id)
    @league = @prediction_game.league
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)
    @teama = Team.find_by_name(@game.teama)
    @teamh = Team.find_by_name(@game.teamh)

    if user_signed_in?
      @usertype = "user"
      @access = current_user

      if @access.customer_id 

        customer = Stripe::Customer.retrieve(current_user.customer_id)

        if customer.default_source

          @payment = true
        else

          @payment = false
        end

      end

    elsif predictor_signed_in?
      @usertype = "predictor"
      @access = current_predictor
    elsif admin_signed_in?
      @usertype = "admin"
    else
      @usertype = "none"
    end
      
      @action = "Predictions"
      
  end

  def buy

    @prediction_game = PredictionGame.find(params[:id])

    if user_signed_in?
      @user = current_user
      @predictor = Predictor.find(@prediction_game.predictor_id)

      Stripe.api_key = Rails.configuration.stripe[:secret_key]
      #Stripe.api_key = current_user.account_key_s

      Stripe::Transfer.create(
        :amount => @prediction_game.cost.round*100,
        :currency => "usd",
        :destination => @predictor.account_id,
        :application_fee => @prediction_game.cost.round*20, 
        :description => "Payment for " + @prediction_game.league + " prediction: " + @prediction_game.teama + " @ " + @prediction_game.teamh
        
      )

      @user.prediction_games << @prediction_game

    ######End transfer approach

      redirect_to predictiongamesshow_path(@predictor.username,@prediction_game.id)

    else

      redirect_to new_user_session_path, notice: 'Please login to purchase predictions.'
      @prediction_game_id = @prediction_game.id

    end
  end

  def findpredictiongames
    
    @game = Game.find(params[:game_id])
    @prediction_games = @game.prediction_games
    @teama = Team.find(@game.teama_id)
    @teamh = Team.find(@game.teamh_id)

    #@prediction_games = PredictionGame.all.where(:game_id => params[:game_id])

    if predictor_signed_in?

    elsif user_signed_in?

      if params[:prediction_game]

        if params[:prediction_game][:sort_param]

          if params[:prediction_game][:sort_param] == "Date: Newest"

            @prediction_games = @prediction_games.sort_by(&:created_at).reverse

          elsif params[:prediction_game][:sort_param] == "Date: Oldest"

            @prediction_games = @prediction_games.sort_by(&:created_at)

          elsif params[:prediction_game][:sort_param] == "Rating (Predictor)"

          elsif params[:prediction_game][:sort_param] == "Rating (Prediction)"

          elsif params[:prediction_game][:sort_param] == "Price"
   
          end

        end

      end

    end

  end

  def nbapredictorindexpredictiongame

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

  def gameselect

    @prediction_game = PredictionGame.new

  end

  # GET /prediction_games/new
  def new

    @game = Game.find(params[:id])

    @league = @game.league

    if @game.event_time > Time.now and @game.status == "o" and not current_predictor.prediction_games.where(:game_id => @game.id).present?

      @prediction_game = PredictionGame.new

      @prediction_game.game_id = @game.id

      @prediction_game.teama = @game.teama

      @prediction_game.teamh = @game.teamh

      @prediction_game.league = @game.league

      @prediction_game.event_time = @game.event_time

      @prediction_game.status = "o"

      @teama = Team.find_by_name(@game.teama)
      @teamh = Team.find_by_name(@game.teamh)

    else

        @prediction_games = PredictionGame.all

        respond_to do |format|
          format.html { render :index }
          format.json { render json: @prediction_game.errors, status: :unprocessable_entity }
        end
    end


  def sportsfindindex

      @prediction_games = PredictionGame.all

  end


  end

  # GET /prediction_games/1/edit
  def edit
  end

  def game

  end

  # POST /prediction_games
  # POST /prediction_games.json

  def create

    if predictor_signed_in?

      @prediction_game = PredictionGame.new(prediction_game_params)

      @predictor = current_predictor

      @game = Game.find(@prediction_game.game_id)

      if @prediction_game.event_time > Time.now and @game.status == "o" and not PredictionGame.where(:game_id => @game.id, :predictor_id => current_predictor.id).present?

        if @prediction_game.teama_score > @prediction_game.teamh_score
          @prediction_game.game_winner = @prediction_game.teama
          @prediction_game.spread = @prediction_game.teama_score - @prediction_game.teamh_score

        elsif @prediction_game.teama_score < @prediction_game.teamh_score
          @prediction_game.game_winner = @prediction_game.teamh
          @prediction_game.spread = @prediction_game.teamh_score - @prediction_game.teama_score

        end

        @prediction_game.predictor_id = @predictor.id

        if @prediction_game.cost.nil?
          @prediction_game.cost = 0
        end

        respond_to do |format|
          if @prediction_game.save

            unless current_predictor.account

              Stripe.api_key = Rails.configuration.stripe[:secret_key]
              account = Stripe::Account.create(
                {:country => "US", :managed => true, :email => @predictor.email, :transfer_schedule["interval"] => "manual"}
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

            format.html { redirect_to @prediction_game, notice: 'Prediction game was successfully created.' }
            format.json { render :show, status: :created, location: @prediction_game }
          else
            format.html { render :new }
            format.json { render json: @prediction_game.errors, status: :unprocessable_entity }
          end
        end

      else
        format.html { render :new }
        format.json { render json: @prediction_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prediction_games/1
  # PATCH/PUT /prediction_games/1.json
  def update
    respond_to do |format|
      if @prediction_game.update(prediction_game_params)
        format.html { redirect_to @prediction_game, notice: 'Prediction game was successfully updated.' }
        format.json { render :show, status: :ok, location: @prediction_game }
      else
        format.html { render :edit }
        format.json { render json: @prediction_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prediction_games/1
  # DELETE /prediction_games/1.json
  def destroy
    @prediction_game.destroy
    respond_to do |format|
      format.html { redirect_to prediction_games_url, notice: 'Prediction game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prediction_game
      @prediction_game = PredictionGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prediction_game_params
      params.require(:prediction_game).permit(:game_winner, :teama_score, :teamh_score, :game_id, :event_time, :status, :teama, :teamh, :league, :article_id, :predictor_id, :cost)
    end
end
