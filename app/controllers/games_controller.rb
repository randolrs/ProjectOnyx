class GamesController < ApplicationController


  # GET /games/new
  def new
    @game = Game.new

  end

# GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
  end

  def gameselect
    @games = Game.all
  end

  def sportsgamesselect

    @predictor = current_predictor

    @games = Game.where("event_time > :time and status = :open", {time: Time.now, open: "o"})

    if params[:league]

      if params[:league] == "all"
        #@games = Game.all
      else 
        @games = @games.all.where(:league => params[:league])
      end
      
    end
    
  end


  # GET /games/1/edit
  def edit

    @game = Game.find(params[:id])
  end

  def create

    @game = Game.new(game_params)

    teama = Team.find_by_name(@game.teama)
    teamh = Team.find_by_name(@game.teamh)

    @game.teama_id = teama.id
    @game.teamh_id = teamh.id

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

  def update

    @game = Game.find(params[:id])

        if @game.status == "c"

          if @game.teama_score > @game.teamh_score

            @game.game_winner = @game.teama

            @game.score_spread = @game.teama_score - @game.teamh_score

          elsif @game.teama_score < @game.teamh_score

            @game.game_winner = @game.teamh

            @game.score_spread = @game.teamh_score - @game.teama_score

          end
            
          #@prediction_games = PredictionGame.find(:all, :conditions => {:game_id => [@game.id]})
          #@prediction_games = PredictionGame.all.where(:game_id => game.id)

          @prediction_games = PredictionGame.where("game_id = :gameid", {gameid: @game.id})

            @prediction_games.each do |prediction_game|

              prediction_game.update(status: "c")
              prediction_game.update(teama_tscore: @game.teama_score)
              prediction_game.update(teamh_tscore: @game.teamh_score)
              prediction_game.update(game_winnert: @game.game_winner)
              prediction_game.update(teama_diff: prediction_game.teama_score - @game.teama_score)
              prediction_game.update(teamh_diff: prediction_game.teamh_score - @game.teamh_score)

              if prediction_game.game_winner == prediction_game.teama
                prediction_game.update(spreadt: @game.teama_score - @game.teamh_score)
              elsif prediction_game.game_winner == prediction_game.teamh
                prediction_game.update(spreadt: @game.teamh_score - @game.teama_score)
              end

              if prediction_game.game_winner == prediction_game.game_winner
                prediction_game.update(game_winner_yesno: true)
              else
                prediction_game.update(game_winner_yesno: false)
              end

              prediction_game.update(spread_diff: prediction_game.spread - @game.score_spread)


            end

        end

      respond_to do |format|

      if @game.update(game_params)

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

    elsif predictor_signed_in?

      @games = Game.all

    end

  end


def findgames
    @games = Game.where(:league => params[:league])

    if user_signed_in?

      if params[:game].nil?

      else

        if (params[:game][:team] && Team.all.collect(&:name).include?(params[:game][:team]) )
          
          @games =  @games.where("teama = :team or teamh = :team", {team: params[:game][:team]})

        end

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
      params.require(:game).permit(:teamh, :teama, :teama_id, :teamh_id, :league, :event_time, :teama_score, :teamh_score, :score_spread, :status, :game_winner, :event_city, :event_venue)
    end

end