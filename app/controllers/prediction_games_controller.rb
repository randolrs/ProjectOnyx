class PredictionGamesController < ApplicationController
  before_action :set_prediction_game, only: [:show, :edit, :update, :destroy]

  # GET /prediction_games
  # GET /prediction_games.json
  def index
    @prediction_games = PredictionGame.all
  end

  # GET /prediction_games/1
  # GET /prediction_games/1.json
  def show
  end

  # GET /prediction_games/new
  def new
    @prediction_game = PredictionGame.new

    @game = Game.find(params[:game])

    @prediction_game.game_id = @game.id

    @prediction_game.teama = @game.teama

    @prediction_game.teamh = @game.teamh

    @prediction_game.league = @game.league

    @prediction_game.event_time = @game.event_time

    @prediction_game.status = "o"


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
    
    if @prediction_game.event_time > Time.now

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
      params.require(:prediction_game).permit(:game_winner, :teama_score, :teamh_score, :game_id, :event_time, :status, :teama, :teamh)
    end
end
