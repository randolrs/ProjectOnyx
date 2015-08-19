class CardsController < ApplicationController

  def new

    redirect_to root_path
  end

  def create

	unless params[:predictor_id].nil?
    @predictor = Predictor.find(params[:predictor_id])
  end
	#@payment = params[:payment]

  	Stripe.api_key = Rails.configuration.stripe[:secret_key]

  	customer = Stripe::Customer.retrieve(current_user.customer_id)

  	if customer.default_source

    else

    	customer.source = params[:stripeToken]

    	customer.save

  	end

	# rescue Stripe::CardError => e
	# 	flash[:error] = e.message
	# 	redirect_to charges_path
	# end

    if @predictor
     	customer.subscriptions.create(:plan => @predictor.subscription_id)

      current_user.predictors << @predictor

    end

    #@predictor.users << current_user

    redirect_to dashboard_path

  end

  def index

      @action = "payment"

      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      @customer = Stripe::Customer.retrieve(current_user.customer_id)

      @defaultcard = @customer.default_source

      @displaycard = @customer.sources.retrieve(@defaultcard)

      @list = Stripe::Customer.retrieve(current_user.customer_id).sources.all(:limit => 3, :object => "card")
  end



end
