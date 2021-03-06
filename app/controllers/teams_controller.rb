class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
      if params[:id]
        @team = Team.find(params[:id])
      elsif params[:team]
        @team = team.find_by_name(params[:team])
      end
      @league = @team.league
      @teams = Team.all.where(:league=>@league)
      @games = @team.upcoming_games
      @displaypredictor = true
      @action = "teams"
      @subaction = "recent"
      @predictions = @team.recent_prediction_games

      @predictors = @team.all_predictors.sort_by {|k| k.rating}

      @top_predictors = @team.all_predictors.sort_by {|k| k.rating}.take(3)

      @upcominggames = @team.upcoming_games.take(3)

  end

  def show_games
    @team = Team.find_by_name(params[:team])
    @league = @team.league
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)
    
    @displaypredictor = true

    @action = "teams"
    @subaction = "games"
    
    @predictions = @team.recent_prediction_games

    @upcominggames = @team.upcoming_games.take(3)

    @top_predictors = @team.all_predictors.sort_by {|k| k.rating}.take(3)

    @team_games = @team.all_games

    @teamshow = true

end

def expertindex

  @team = Team.find_by_name(params[:team])
  @league = @team.league

  @experts = @team.all_predictors


end

def show_predictors
    @team = Team.find(params[:id])
    @league = @team.league
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)

    @displaypredictor = true

    @predictions = @team.recent_prediction_games

    @predictors = @team.all_predictors.sort_by {|k| k.rating}

    @action = "teams"
    @subaction = "top"

    @upcominggames = @team.upcoming_games.take(3)

    @top_predictors = @team.all_predictors.sort_by {|k| k.rating}.take(3)

end

  def teamgameindex
      @team = Team.find_by_name(params[:team])
      @league = @team.league
      @sport = Sport.find_by_subcat(@league)
      @teams = Team.all.where(:league=>@league)
      @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 10)
      @articles = Article.all.where("teama = :team or teamh = :team", {team: @team.name})
      @predictions = PredictionGame.all.where("teama = :team or teamh = :team", {team: @team.name})
      @teamgames = @games.where("teama = :team or teamh = :team", {team: @team.name})

      if params[:season]

        @season = params[:season]

      else

        @season = @sport.current_season

      end

      @games_schedule = @team.schedule_games(@season)
  end

  def articleindex
      @team = Team.find(params[:id])
      @league = @team.league
      @teams = Team.all.where(:league=>@league)
      @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 10)
      @articles = Article.all.where("teama = :team or teamh = :team", {team: @team.name})
      @predictions = PredictionGame.all.where("teama = :team or teamh = :team", {team: @team.name})
      @teamgames = Game.all.where(:league => @team.league)
      @teamgames = @games.where("teama = :team or teamh = :team", {team: @team.name})
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  def predictionindex
    @team = Team.find(params[:id])
    @league = @team.league
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)
    @predictions = PredictionGame.all.where("teama = :team or teamh = :team", {team: @team.name})
    @displaypredictor = true

  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  def teamindex(subcat)

    @gigs = Gig.find(:all, :conditions => {:league => subcat})


  end


  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :sub_name, :full_name, :league, :sport_id, :image, :sub_category)
    end
end
