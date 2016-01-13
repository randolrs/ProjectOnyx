class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
  end

  def purchase

    if user_signed_in?

        Stripe.api_key = Rails.configuration.stripe[:secret_key]

        customer = Stripe::Customer.retrieve(@user.customer_id)

        @plan = Plan.find_by_description(params[:description])

        customer.subscriptions.create(:plan => @plan.stripe_id)

    end

    redirect_to root_path

  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    if admin_signed_in?
      @plan = Plan.new
    end
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create

    if admin_signed_in?
      @plan = Plan.new(plan_params)

      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      plan = Stripe::Plan.create(
            :amount => (@plan.cost * 100).to_i,
            :interval => 'month',
            :name => @plan.description,
            :currency => 'usd',
            :id => @plan.stripe_id
            )

      respond_to do |format|
        if @plan.save
          format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
          format.json { render :show, status: :created, location: @plan }
        else
          format.html { render :new }
          format.json { render json: @plan.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:stripe_id, :description, :cost, :credit_per_month)
    end
end
