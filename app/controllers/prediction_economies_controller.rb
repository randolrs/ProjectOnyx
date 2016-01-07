class PredictionEconomiesController < ApplicationController
  before_action :set_prediction_economy, only: [:show, :edit, :update, :destroy]

  # GET /prediction_economies
  # GET /prediction_economies.json
  def index
    @prediction_economies = PredictionEconomy.all
  end

  # GET /prediction_economies/1
  # GET /prediction_economies/1.json
  def show
  end

  # GET /prediction_economies/new
  def new
    @prediction_economy = PredictionEconomy.new
  end

  # GET /prediction_economies/1/edit
  def edit
  end

  # POST /prediction_economies
  # POST /prediction_economies.json
  def create
    @prediction_economy = PredictionEconomy.new(prediction_economy_params)

    respond_to do |format|
      if @prediction_economy.save
        format.html { redirect_to @prediction_economy, notice: 'Prediction economy was successfully created.' }
        format.json { render :show, status: :created, location: @prediction_economy }
      else
        format.html { render :new }
        format.json { render json: @prediction_economy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prediction_economies/1
  # PATCH/PUT /prediction_economies/1.json
  def update
    respond_to do |format|
      if @prediction_economy.update(prediction_economy_params)
        format.html { redirect_to @prediction_economy, notice: 'Prediction economy was successfully updated.' }
        format.json { render :show, status: :ok, location: @prediction_economy }
      else
        format.html { render :edit }
        format.json { render json: @prediction_economy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prediction_economies/1
  # DELETE /prediction_economies/1.json
  def destroy
    @prediction_economy.destroy
    respond_to do |format|
      format.html { redirect_to prediction_economies_url, notice: 'Prediction economy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prediction_economy
      @prediction_economy = PredictionEconomy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prediction_economy_params
      params.require(:prediction_economy).permit(:type, :type_id, :strike_date, :strike_description, :country, :value)
    end
end
