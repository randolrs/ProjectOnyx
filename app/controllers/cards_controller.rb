class CardsController < ApplicationController

  def create

	@predictor = Predictor.find(params[:predictor_id])
	#@payment = params[:payment]

  	Stripe.api_key = Rails.configuration.stripe[:secret_key]

  	customer = Stripe::Customer.retrieve(current_user.customer_id)

  	if @payment == false

  	customer.source = params[:stripeToken]

  	customer.save

  	end

	# rescue Stripe::CardError => e
	# 	flash[:error] = e.message
	# 	redirect_to charges_path
	# end

   	customer.subscriptions.create(:plan => @predictor.subscription_id)

    current_user.predictors << @predictor

    #@predictor.users << current_user

    redirect_to dashboard_path

  end

  def index

    @action = "payment"
      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      @list = Stripe::Customer.retrieve(current_user.customer_id).sources.all(:limit => 3, :object => "card")
  end



end
