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
    @displaypredictor = false

    if user_signed_in?
      
      @userPredictorPurchase = Purchase.where(:user_id=>current_user.id, :predictor_id => @predictor.id)

      unless @userPredictorPurchase.empty?

        @premium_access = @userPredictorPurchase.first.premium
        
      else

        @premium_access = false

      end

    elsif predictor_signed_in?
      
      if current_predictor.id == @predictor.id
        @premium_access = true
      else
        @premium_access = false
      end

    elsif admin_signed_in?

      @premium_access = true
    
    else

      @premium_access = false

    end
      

      #need to add logic for sorted array that includes both premium and non premium predictions

    @predictions = Array.new 

    if params[:sort_by]

      if params[:sort_by] == "upcoming"

        @action = "upcoming"
        @predictions = @predictor.my_prediction_games_upcoming(@premium_access)

      elsif params[:sort_by] == "top"

        @action = "top"
        @predictions = @predictor.my_prediction_games_closed(@premium_access)

      elsif params[:sort_by] == "closed"

        @action = "closed"
        @predictions = @predictor.my_prediction_games_closed(@premium_access)

      else

        @action = "recent"

        @predictor.prediction_games.each do |prediction_game|

          hash = {:prediction=>prediction_game, :predictor=>@predictor, :premium_access=> @premium_access}

          @predictions << hash

        end

      end

    else

      @action = "recent"

      @predictions = @predictor.recent_prediction_games(@premium_access)

    end

    @top_predictions = @predictor.prediction_games.where("onyx > :zero", {zero: 0}).limit(3)

  end

  def predictorpaymentedit
    @action = "Payments"
    @predictor = Predictor.find_by_username(params[:username])

  end

  def subscribe

    @predictor = Predictor.find_by_username(params[:username])
    @user = current_user

    if user_signed_in?

      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      if @user.customer_id

        customer = Stripe::Customer.retrieve(current_user.customer_id)

      else

        customer = Stripe::Customer.create(
                    :description => "Customer for Onyx",
                    )
      end

      #the logic in the next section is incomplete

      if Purchase.exists?(:user_id=> @user.id,:predictor_id=>@predictor.id)

        @purchase = Purchase.where(:user_id=> @user.id,:predictor_id=>@predictor.id)

        @purchase.each do |purchase|
          purchase.update(:premium => true)
        end

      else

        @purchase = Purchase.new

        @purchase.user_id = @user.id

        @purchase.predictor_id = @predictor.id

        @purchase.price = @predictor.subscription_price

        @purchase.premium = true

        customer.subscriptions.create(:plan => @predictor.subscription_id)

        @purchase.save        

      end

      redirect_to root_path

    end
  end

  def subscriberindex
    @action = 'subscriberindex'
    @predictor = Predictor.find_by_username(params[:username])
    @subscribers = @predictor.users

  end

  def predictorindex
    @action = "experts"

    if user_signed_in?
      
      @myPurchases = Purchase.all.where(:user_id => current_user.id)

      @predictors = current_user.my_predictors

    end

  end

  def predictorbalance

    if predictor_signed_in?

      @predictor = current_predictor

      @followers_count = @predictor.purchases.count
      @subscriptions_count = @predictor.purchases.all.where(:premium => true).count
      @current_balance = 0

    else

      redirect_to root_path

    end

  end

  def follow

    if user_signed_in?

      @predictor = Predictor.find_by_username(params[:username])

      unless current_user.predictors.exists?(:id => @predictor.id)

        @purchase = Purchase.new

        @purchase.user_id = current_user.id

        @purchase.predictor_id = @predictor.id

        @purchase.premium = false

        @purchase.save

        #current_user.predictors << @predictor

        redirect_to root_path

      else

        redirect_to root_path

      end

    end

  end

  def update_predictor_price

    if predictor_signed_in?

      if params[:newsubscriptionprice]

        current_predictor.update(:subscription_price => params[:newsubscriptionprice])

      end

      redirect_to predictorbalance_path(current_predictor.username)

    else

      redirect_to root_path
    end


  end

end