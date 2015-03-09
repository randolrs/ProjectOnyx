class PredictionGamesController < ApplicationController
  before_action :set_prediction_game, only: [:show, :edit, :update, :destroy]

  # GET /prediction_games
  # GET /prediction_games.json
  
  def index

    @prediction_games = PredictionGame.all

    if predictor_signed_in?

    elsif user_signed_in?

      if params[:league].nil?

      else
        @prediction_games = @prediction_games.where(:league => params[:league])
      end

      if params[:prediction_game].nil?

      else

        # works

        # if (params[:prediction_game][:league] && PredictionGame.all.collect(&:league).include?(params[:league]))
          
        #   #@prediction_games = PredictionGame.all.where(:league => params[:prediction_game][:league])

        #   @prediction_games = @prediction_games.all.where(:league => params[:prediction_game][:league])


        # end

         if (params[:prediction_game][:teama] && PredictionGame.all.collect(&:teama).include?(params[:teama]) )
          
          @prediction_games =  @prediction_games.where(:teama => params[:prediction_game][:teama])

        end


      end

    end

  end

  # def findnbapredictiongames

  #   if params[:prediction_game]

  #     if params[:prediction_game][:game_id]
  #       @prediction_games = PredictionGame.all.where(:league => "NBA", :game_id => params[:prediction_game][:game_id])

  #     else
  #       @prediction_games = PredictionGame.all.where(:league => "NBA")
        
  #     end

  #     if params[:prediction_game][:sort_param]

  #       if params[:prediction_game][:sort_param] == "Date: Newest"

  #         @prediction_games = @prediction_games.sort_by(&:created_at).reverse

  #       elsif params[:prediction_game][:sort_param] == "Date: Oldest"

  #         @prediction_games = @prediction_games.sort_by(&:created_at)

  #       elsif params[:prediction_game][:sort_param] == "Rating (Predictor)"


  #       elsif params[:prediction_game][:sort_param] == "Rating (Prediction)"


  #       elsif params[:prediction_game][:sort_param] == "Price"

          
          
  #       end

  #     end

  #   else

  #     if params[:game_id]

  #       @prediction_games = PredictionGame.all.where(:league => "NBA", :game_id => params[:game_id])

  #     else
  #       @prediction_games = PredictionGame.all.where(:league => "NBA")
        
  #     end

  #   end

  #   if predictor_signed_in?


  #   elsif user_signed_in?

  #     if params[:prediction_game].nil?


  #     else

  #       # works

  #       # if (params[:prediction_game][:league] && PredictionGame.all.collect(&:league).include?(params[:league]))
          
  #       #   #@prediction_games = PredictionGame.all.where(:league => params[:prediction_game][:league])

  #       #   @prediction_games = @prediction_games.all.where(:league => params[:prediction_game][:league])


  #       # end

  #       if (params[:prediction_game][:teama] && Team.all.collect(&:name).include?(params[:prediction_game][:teama]) )
          
  #         @prediction_games =  @prediction_games.where("teama = :teama or teamh = :teama", {teama: params[:prediction_game][:teama]})

  #         #@prediction_games =  @prediction_games.where(:teama => params[:prediction_game][:teama])
  #         #"teama = :teama or teamh = :teama", { teama: params[:prediction_game][:teama], teama: params[:prediction_game][:teama] }

  #       end


  #     end

  #   end


  # end


  def index_closed
    @prediction_games = PredictionGame.all
  end

  # GET /prediction_games/1
  # GET /prediction_games/1.json
  def show

    @prediction_game = PredictionGame.find(params[:id])
    @user = current_user
  end

  def buy
    @prediction_game = PredictionGame.find(params[:id])
    @user = current_user

    @user.prediction_games << @prediction_game

    redirect_to home_path

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

      elsif params[:category] = "finance"

      elsif params[:category] = "politics"

      elsif params[:category] = "weather"

      end

    else
        @predictions = @predictor.prediction_games

    end
    
  end

  def gameselect

    @prediction_game = PredictionGame.new

  end

  # GET /prediction_games/new
  def new

    game = Game.find(params[:game])

    if game.event_time > Time.now and game.status == "o" and not PredictionGame.where(:game_id => game.id, :predictor_id => current_predictor.id).present?

      @prediction_game = PredictionGame.new

      @prediction_game.game_id = game.id

      @prediction_game.teama = game.teama

      @prediction_game.teamh = game.teamh

      @prediction_game.league = game.league

      @prediction_game.event_time = game.event_time

      @prediction_game.status = "o"

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

    @prediction_game = PredictionGame.new(prediction_game_params)

    game = Game.find(@prediction_game.game_id)

    if @prediction_game.event_time > Time.now and game.status == "o" and not PredictionGame.where(:game_id => game.id, :predictor_id => current_predictor.id).present?

      if @prediction_game.game_winner == @prediction_game.teamh
        @prediction_game.spread = @prediction_game.teamh_score - @prediction_game.teama_score

      elsif @prediction_game.game_winner == @prediction_game.teama
        @prediction_game.spread = @prediction_game.teama_score - @prediction_game.teamh_score

      end

      @prediction_game.predictor_id = current_predictor.id

      respond_to do |format|
        if @prediction_game.save
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
      params.require(:prediction_game).permit(:game_winner, :teama_score, :teamh_score, :game_id, :event_time, :status, :teama, :teamh, :league)
    end
end
