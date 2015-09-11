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

    customer = Stripe::Customer.retrieve(current_user.customer_id)

    customer.sources.create(:source => token.id)

    customer.save

  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to charges_path
  # end

    if @predictor
      customer.subscriptions.create(:plan => @predictor.subscription_id)

      current_user.predictors << @predictor

    end

    redirect_to cardsindex_path(current_user.username)

  end

  def index

    @action = "payment"

    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    @customer = Stripe::Customer.retrieve(current_user.customer_id)

    if @customer.default_source

      @defaultcard = @customer.default_source

      @displaycard = @customer.sources.retrieve(@defaultcard)

      @list = @customer.sources.all(:limit => 5, :object => "card")

      @cards = @list.data

    end

  end

  def make_default

    if params[:newdefault]

      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      customer = Stripe::Customer.retrieve(current_user.customer_id)

      customer.default_source = params[:newdefault]

      customer.save

    end

      redirect_to cardsindex_path(current_user.username)

  end

end
