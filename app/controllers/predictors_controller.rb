class PredictorsController < ApplicationController

  def findsportspredictors
  	@predictors = Predictor.all

  end

  def predictionindex

    @action = 'predictionindex'

    #params[:username] = params[:username].downcase

    #@predictor = Predictor.find(:first, :conditions => ["lower(username) = ?", params[:username].downcase]) 
    @predictor = Predictor.find_by_username(params[:username])

    if params[:category] 

      if params[:category] = "sports"

        @predictions = @predictor.prediction_games

        if params[:league]

            if params[:league] == "NBA"

              @predictions = @predictor.prediction_games.where(:league => "NBA")

            elsif params[:league] == "NFL"

              @predictions = @predictor.prediction_games.where(:league => "NFL")

            elsif params[:league] == "MLB"

              @predictions = @predictor.prediction_games.where(:league => "MLB")

            elsif params[:league] == "NHL"

              @predictions = @predictor.prediction_games.where(:league => "NHL")

            end
        end
            
          if params[:team_filter]
            #@predictions = @predictions.all.where(:teama => params[:prediction_game][:team])

            @predictions = @predictions.where("teama = :team or teamh = :team", {team: params[:team_filter][:team]})
          end

      elsif params[:category] = "finance"

      elsif params[:category] = "politics"

      elsif params[:category] = "weather"

      end

    else
        @predictions = @predictor.prediction_games

    end

       @predictions = @predictions.order("created_at DESC").paginate(:page =>params[:page], :per_page => 10)

       @displaypredictor = false

  end

  def articleindex
    @action = 'articleindex'
    @predictor = Predictor.find_by_username(params[:username])
    @articles = @predictor.articles.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)

  end

  def predictordashboard
    @action = 'predictordashboard'
    @predictor = Predictor.find_by_username(params[:username])
    @predictions = @predictor.prediction_games.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @articles = @predictor.articles.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    @displaypredictor = false
    #@subscriber_count = @predictor.users.count
  end

  def predictorpaymentedit
    @action = "Payments"
    @predictor = Predictor.find_by_username(params[:username])

  end

  def subscribe

    if user_signed_in?

      if current_user.customer_id

      @predictor = Predictor.find_by_username(params[:username])

      Stripe.api_key = Rails.configuration.stripe[:secret_key]
      
      #Stripe.api_key = @predictor.account_key_secret

        unless current_user.predictors.exists?(:id => @predictor.id)

          customer = Stripe::Customer.retrieve(current_user.customer_id)

          customer.subscriptions.create(:plan => @predictor.subscription_id)

          current_user.predictors << @predictor

          @predictor.users << current_user

          redirect_to dashboard_path

        else

          redirect_to dashboard_path
        end

      else

        #else logic for current_user.customer_id
      end
    end
  end

  def subscriberindex
    @action = 'subscriberindex'
    @predictor = Predictor.find_by_username(params[:username])
    @subscribers = @predictor.users

  end

end