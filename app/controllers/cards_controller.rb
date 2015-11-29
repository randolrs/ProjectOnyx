class CardsController < ApplicationController

  def new

    unless params[:predictor_id].nil?
      @predictor = Predictor.find(params[:predictor_id])
    end

    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    token = Stripe::Token.create(
    :card => {
    :number => params[:number],
    :exp_month => params[:exp-month],
    :exp_year => params[:exp-year],
    :cvc => params[:cvc]
              },
                )

    unless current_user.customer_id

      customer = Stripe::Customer.create(
                :description => "Customer for Onyx",
                #:source => params[:stripeToken] # obtained with Stripe.js
                )

      current_user.update(:customer_id => customer.id)

    end

    customer = Stripe::Customer.retrieve(current_user.customer_id)

    customer.source = token

    customer.save

  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to charges_path
  # end

    if @predictor
      customer.subscriptions.create(:plan => @predictor.subscription_id)

      current_user.predictors << @predictor

    end

  end

  def create

    @user = current_user

    unless params[:predictor_id].nil?
      @predictor = Predictor.find(params[:predictor_id])
    end

    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    token = Stripe::Token.create(
    :card => {
    :number => params[:number],
    :exp_month => params[:expmonth],
    :exp_year => params[:expyear],
    :cvc => params[:cvc]
              },
                )

    unless current_user.customer_id

      customer = Stripe::Customer.create(
                :description => "Customer for Onyx",
                #:source => params[:stripeToken] # obtained with Stripe.js
                )

      current_user.update(:customer_id => customer.id)

    end

    customer = Stripe::Customer.retrieve(current_user.customer_id)

    customer.sources.create(:source => token.id)

    customer.save

  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to charges_path
  # end

    if @predictor
        
        if Purchase.exists?(:user_id=> @user.id,:predictor_id=>@predictor.id)

          @purchase = Purchase.where(:user_id=> @user.id,:predictor_id=>@predictor.id)

          @purchase.each do |purchase|
            purchase.update(:premium => true)
          end

        else

          @purchase = Purchase.new

          @purchase.user_id = @user.id

          @purchase.predictor_id = @predictor.id

          @purchase.premium = true

          customer.subscriptions.create(:plan => @predictor.subscription_id)

          @purchase.save        

        end

      redirect_to root_path

    else

      redirect_to payments_path

    end

  end

  def index

    @action = "payment"

    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    if current_user.customer_id

      @customer = Stripe::Customer.retrieve(current_user.customer_id)

      if @customer.default_source

        @defaultcard = @customer.default_source

        @displaycard = @customer.sources.retrieve(@defaultcard)

        @list = @customer.sources.all(:limit => 5, :object => "card")

        @cards = @list.data

      end

    end

  end

  def make_default

    if params[:newdefault]

      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      customer = Stripe::Customer.retrieve(current_user.customer_id)

      customer.default_source = params[:newdefault]

      customer.save

      if user_signed_in?

        current_user.update(:default_source => customer.default_source)
      end

    end

      redirect_to cardsindex_path(current_user.username)

  end

end
