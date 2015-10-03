class GamesController < ApplicationController

  # GET /games/new
  def new
    @game = Game.new
  end

# GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    #@predictions = PredictionGame.all.where(:game_id=>params[:id]).order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
    @articles = Article.all.where(:event_id=>@game.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @teams = Team.all.where(:league=>params[:league])
    @games = Game.all.where(:league=>params[:league]).order("event_time DESC").paginate(:page => params[:page], :per_page => 5)
    @league = @game.league
    @sport = Sport.find_by_subcat(@league)
    @teama = Team.find_by_name(@game.teama)
    @teamh = Team.find_by_name(@game.teamh)
    @displaypredictor = true
    @action = "games"
    @matchup_hide = true
    @predictions = @game.recent_prediction_games

    @othergames = @game.other_games.take(3)

  end

  def gameselect
    @games = Game.all
  end

  def sportsgamesselect

    @predictor = current_predictor

    @games = Game.where("event_time > :time and status = :open", {time: Time.now, open: "o"})

    @counter = 0

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

    respond_to do |format|

      if @game.update(game_params)

        if @game.status == "c"

          if @game.teama_score > @game.teamh_score

            @game.update(game_winner: @game.teama)

            @game.update(score_spread: @game.teama_score - @game.teamh_score)

          elsif @game.teama_score < @game.teamh_score

            @game.update(game_winner: @game.teamh)

            @game.update(score_spread: @game.teamh_score - @game.teama_score)

          end

          @prediction_games = PredictionGame.where("game_id = :gameid", {gameid: @game.id})

          @prediction_games.each do |prediction_game|

          prediction_game.update(status: "c")
          prediction_game.update(teama_tscore: @game.teama_score)
          prediction_game.update(teamh_tscore: @game.teamh_score)
          prediction_game.update(game_winnert: @game.game_winner)
          prediction_game.update(teama_diff: prediction_game.teama_score - @game.teama_score)
          prediction_game.update(teamh_diff: prediction_game.teamh_score - @game.teamh_score)

          @ou_diff = (prediction_game.teamh_score + prediction_game.teama_score -
                                          @game.teamh_score + @game.teama_score).abs

          prediction_game.update(ou_diff: @ou_diff)

          if prediction_game.game_winner == prediction_game.teama
            prediction_game.update(spreadt: @game.teama_score - @game.teamh_score)
          elsif prediction_game.game_winner == prediction_game.teamh
            prediction_game.update(spreadt: @game.teamh_score - @game.teama_score)
          end

          if prediction_game.game_winner == @game.game_winner
            prediction_game.update(game_winner_yesno: true)
            @spread_diff = (prediction_game.spread - @game.score_spread).abs
          else
            prediction_game.update(game_winner_yesno: false)
            @spread_diff = (prediction_game.spread + @game.score_spread).abs
          end

          prediction_game.update(spread_diff: @spread_diff)

          #winner onyx points

          if prediction_game.game_winner_yesno

            prediction_game.update(onyx: 50)
          else

            prediction_game.update(onyx: 0)

          end

        end

        n = 0
        #spread points
         @prediction_games_spread = @prediction_games.order("spread_diff DESC")

         @prediction_games_spread.each do |prediction_game|

            n = n+1

            @newrating = prediction_game.onyx + n*(40/@prediction_games.count)

            prediction_game.update(onyx: @newrating)

          end

          n=0

        #over/under points

         @prediction_games_ou_diff = @prediction_games.order("ou_diff DESC")

         @prediction_games_ou_diff.each do |prediction_game|

          n = n+1

          @newrating = prediction_game.onyx + n*(10/@prediction_games.count)

          prediction_game.update(onyx: @newrating)

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