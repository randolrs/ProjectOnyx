class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # Get /games/1/score
  def score
  end

  def gameselect

    @games = Game.all
    #@games = Game.find(:all, :conditions => {:event_time => Time.now})

  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end

    end

  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    
    respond_to do |format|
      if @game.update(game_params)

          if @game.status == "c"

              #all predictions got closed - updated records for all prediction games

                  @prediction_games = PredictionGame.all

                  @prediction_games.each do |prediction_game|

                    if prediction_game.game_id == @game.id and @game.status == "c"

                      prediction_game.update(status: "c")
                      prediction_game.update(teama_tscore: @game.teama_score)
                      prediction_game.update(teamh_tscore: @game.teamh_score)
                      prediction_game.update(game_winnert: @game.game_winner)
                      

                    end

                end

              #end
          
          end

        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end

    


  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game

        if admin_signed_in?

          @game = Game.find(params[:id])

        else

          redirect_to root_url # halts request cycle
          flash[:error] = "Get out of here - Beat it! -- You heard me"
        end

    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:teamh, :teama, :league, :event_time, :teama_score, :teamh_score, :score_spread, :status)
    end
end
