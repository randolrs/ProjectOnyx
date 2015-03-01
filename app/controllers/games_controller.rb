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


  # GET /games/1/edit
  def edit

    @game = Game.find(params[:id])
  end

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

  def update

    @game = Game.find(params[:id])

    respond_to do |format|

      if @game.update(game_params)

        

        if @game.status == "c"

          #@prediction_games = PredictionGame.find(:all, :conditions => {:game_id => [@game.id]})
          @prediction_games = PredictionGame.all

            @prediction_games.each do |prediction_game|

              if prediction_game.game_id == @game.id

                prediction_game.update(status: "c")
                prediction_game.update(teama_tscore: @game.teama_score)
                prediction_game.update(teamh_tscore: @game.teamh_score)
                prediction_game.update(game_winnert: @game.game_winner)

              if prediction_game.game_winner == prediction_game.teama
                prediction_game.update(spreadt: @game.teama_score - @game.teamh_score)
              elsif prediction_game.game_winner == prediction_game.teamh
                prediction_game.update(spreadt: @game.teamh_score - @game.teama_score)
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

  def findnbagames
    @games = Game.where(:league => "NBA")

    if user_signed_in?

      if params[:game].nil?

      else

        if (params[:game][:team] && Team.all.collect(&:name).include?(params[:game][:team]) )
          
          @games =  @games.where("teama = :team or teamh = :team", {team: params[:game][:team]})

        end

      end

    end


  end

  def findnflgames
    @games = Game.where(:league => "NFL")

    if user_signed_in?

      if params[:game].nil?

      else

        if (params[:game][:team] && Team.all.collect(&:name).include?(params[:game][:team]) )
          
          @games =  @games.where("teama = :team or teamh = :team", {team: params[:game][:team]})

        end

      end

    end


  end

  def findmlbgames
    @games = Game.where(:league => "MLB")

    if user_signed_in?

      if params[:game].nil?

      else

        if (params[:game][:team] && Team.all.collect(&:name).include?(params[:game][:team]) )
          
          @games =  @games.where("teama = :team or teamh = :team", {team: params[:game][:team]})

        end

      end

    end


  end

  def findnhlgames
    @games = Game.where(:league => "NHL")

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
      params.require(:game).permit(:teamh, :teama, :league, :event_time, :teama_score, :teamh_score, :score_spread, :status, :game_winner)
    end

end