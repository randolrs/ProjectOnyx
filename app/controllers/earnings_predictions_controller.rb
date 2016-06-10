class EarningsPredictionsController < ApplicationController
  before_action :set_earnings_prediction, only: [:show, :edit, :update, :destroy]

  # GET /earnings_predictions
  # GET /earnings_predictions.json
  def index
    @earnings_predictions = EarningsPrediction.all
  end

  # GET /earnings_predictions/1
  # GET /earnings_predictions/1.json
  def show
  end

  # GET /earnings_predictions/new
  def new
    @earnings_prediction = EarningsPrediction.new
  end

  # GET /earnings_predictions/1/edit
  def edit
  end

  # POST /earnings_predictions
  # POST /earnings_predictions.json
  def create
    @earnings_prediction = EarningsPrediction.new(earnings_prediction_params)

    respond_to do |format|
      if @earnings_prediction.save
        format.html { redirect_to @earnings_prediction, notice: 'Earnings prediction was successfully created.' }
        format.json { render :show, status: :created, location: @earnings_prediction }
      else
        format.html { render :new }
        format.json { render json: @earnings_prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /earnings_predictions/1
  # PATCH/PUT /earnings_predictions/1.json
  def update
    respond_to do |format|
      if @earnings_prediction.update(earnings_prediction_params)
        format.html { redirect_to @earnings_prediction, notice: 'Earnings prediction was successfully updated.' }
        format.json { render :show, status: :ok, location: @earnings_prediction }
      else
        format.html { render :edit }
        format.json { render json: @earnings_prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /earnings_predictions/1
  # DELETE /earnings_predictions/1.json
  def destroy
    @earnings_prediction.destroy
    respond_to do |format|
      format.html { redirect_to earnings_predictions_url, notice: 'Earnings prediction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earnings_prediction
      @earnings_prediction = EarningsPrediction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def earnings_prediction_params
      params.require(:earnings_prediction).permit(:company_id, :company, :ticker, :eps_estimate, :quarter, :year, :status, :eps_actual, :rating)
    end
end
