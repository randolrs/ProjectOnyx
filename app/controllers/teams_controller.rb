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
      @team = Team.find(params[:id])
      @league = @team.league
      @teams = Team.all.where(:league=>@league)
      @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)
      @articles = Article.all.where("teama = :team or teamh = :team", {team: @team.name})
      @teamgames = Game.all.where(:league => @team.league)
      @teamgames = @games.where("teama = :team or teamh = :team", {team: @team.name})
      @displaypredictor = true
      @action = "upcoming"
      @predictions = @team.recent_prediction_games

      @upcominggames = @team.upcoming_games.take(3)
  end

  def show_games
    @team = Team.find(params[:id])
    @league = @team.league
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)
    @articles = Article.all.where("teama = :team or teamh = :team", {team: @team.name})
    @teamgames = Game.all.where(:league => @team.league)
    @teamgames = @games.where("teama = :team or teamh = :team", {team: @team.name})
    @displaypredictor = true
    @action = "games"
    @predictions = @team.recent_prediction_games

    @upcominggames = @team.upcoming_games.take(3)
end

def show_predictors
    @team = Team.find(params[:id])
    @league = @team.league
    @teams = Team.all.where(:league=>@league)
    @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 4)
    @teamgames = Game.all.where(:league => @team.league)
    @teamgames = @games.where("teama = :team or teamh = :team", {team: @team.name})
    @displaypredictor = true

    @predictions = @team.recent_prediction_games

    @predictors = Predictor.all

    @action = "top"

    @upcominggames = @team.upcoming_games.take(3)
end

  def teamgameindex
    @team = Team.find(params[:id])
      @league = @team.league
      @teams = Team.all.where(:league=>@league)
      @games = Game.all.where(:league=>@league).order("event_time DESC").paginate(:page => params[:page], :per_page => 10)
      @articles = Article.all.where("teama = :team or teamh = :team", {team: @team.name})
      @predictions = PredictionGame.all.where("teama = :team or teamh = :team", {team: @team.name})
      @teamgames = Game.all.where(:league => @team.league)
      @teamgames = @games.where("teama = :team or teamh = :team", {team: @team.name})
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
      params.require(:team).permit(:name, :league, :sport_id, :image)
    end
end
