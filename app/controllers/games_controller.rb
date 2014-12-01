class GamesController < ApplicationController


  # GET /games/new
  def new
    @game = Game.new
  end

# GET /predictions/1
  # GET /predictions/1.json
  def show
    @game = Game.find(params[:id])
  end


  # GET /games/1/edit
  def edit

    @game = Game.find(params[:id])
  end

  def create
  end

  def update

    @game = Game.find(params[:id])

    respond_to do |format|

      if @game.update(game_params)

        

        if @game.status = "c"

          #@prediction_games = PredictionGame.find(:all, :conditions => {:game_id => [@game.id]})
          @prediction_games = PredictionGame.all

            @prediction_games.each do |prediction_game|

              if prediction_game.game_id = @game.id

                prediction_game.update(status: "c")
                prediction_game.update(teama_score: @game.teama_score)
                prediction_game.update(teamh_score: @game.teamh_score)

              if @game.teama_score > @game.teamh_score
                prediction_game.update(spread: @game.teama_score - @game.teamh_score)
              elsif @game.teamh_score > @game.teama_score
                prediction_game.update(spread: @game.teamh_score - @game.teama_score)
              end

              end



            end

        end



        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def index

    if admin_signed_in?

    @games = Game.all

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