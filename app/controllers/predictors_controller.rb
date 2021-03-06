class PredictorsController < ApplicationController

  def findsportspredictors
  	@predictors = Predictor.all

  end

  def predictionindex

    @page="predictions"
    @predictor = Predictor.find_by_username(params[:username])
    @displaypredictor = false

    @predictions = Array.new 

    @predictions_rated = Array.new
    @predictions_rated = @predictor.rated_predictions

    @predictions_recent = Array.new

    @predictions_recent = @predictor.recent_prediction_games.sort_by {|k| k[:prediction].created_at}.reverse


  end

  def rating

    @page="rating"
    @predictor = Predictor.find_by_username(params[:username])

    @predictions = Array.new 

    @predictions_rated = Array.new
    @predictions_rated = @predictor.rated_predictions

    @predictions_recent = Array.new

    @predictions_recent = @predictor.recent_prediction_games.sort_by {|k| k[:prediction].created_at}.reverse


  end

  def articleindex
    @action = 'articleindex'
    @predictor = Predictor.find_by_username(params[:username])
    @articles = @predictor.articles.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)

  end

  def predictordashboard
    @action = 'predictordashboard'
    @page="posts"
    @predictor = Predictor.find_by_username(params[:username])
    @displaypredictor = false

    @predictions = Array.new 

    @predictions_rated = Array.new
    @predictions_rated = @predictor.rated_predictions

    @predictions_recent = Array.new

    @predictions_recent = @predictor.recent_prediction_games.sort_by {|k| k[:prediction].created_at}.reverse

    @predictions_top = @predictions_rated.sort_by {|k| k[:prediction].onyx}.reverse

    @predictions_top = @predictions_top.take(5)

    @articles_recent = @predictor.articles.sort_by {|k| k.created_at}.reverse

    @top_articles = @predictor.articles.sort_by {|k| k.recommendation_count}.take(5)

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
          purchase.update(:active => true)

        end

      else

        @purchase = Purchase.new

        @purchase.user_id = @user.id

        @purchase.predictor_id = @predictor.id

        @purchase.price = @predictor.subscription_price

        @purchase.next_payment = Time.now + 31.days

        @purchase.premium = true

        @purchase.active = true

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

  def subscribe_confirm

     @predictor = Predictor.find_by_username(params[:predictor])

     @price = @predictor.subscription_price

     if user_signed_in?

      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      @payment_source = false

        unless current_user.customer_id

          email = current_user.email

          customer = Stripe::Customer.create(
                    :description => email
                    )

          current_user.update(:customer_id => customer.id)

        else

          customer = Stripe::Customer.retrieve(current_user.customer_id)

          if customer.default_source

            # @defaultcard = customer.default_source

            @payment_source = true

            # @displaycard = customer.sources.retrieve(@defaultcard)

            # @list = customer.sources.all(:limit => 5, :object => "card")

            # @cards = @list.data

          end

        end

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

        @purchase.active = true

        @purchase.save

      else

        @purchase = Purchase.where(:user_id=> current_user.id,:predictor_id=>@predictor.id)

        @purchase.each do |purchase|
          purchase.update(:active=> true)
        end

      end

      redirect_to root_path

    end

  end

  def update_predictor_price

    if predictor_signed_in?

      if params[:newsubscriptionprice]

        price = params[:newsubscriptionprice]

        current_predictor.update(:subscription_price => price)

      end


    end

    redirect_to root_path

  end

  def ajax_following

    if predictor_signed_in?

      if params[:following_id]

        @predictor = Predictor.find(params[:following_id])

        unless @predictor.has_follower_active(current_predictor.id)

          unless @predictor.has_follower_inactive(current_predictor.id)
        
            @following = Following.new

            @following.update(:follower_id => current_predictor.id, :following_id => @predictor.id, :active => true)

            @following.save

          else

            @following = Following.where(:follower_id => current_predictor.id, :following_id => @predictor.id).first

            @following.update(:active => true)

          end

          respond_to do |format|
            format.js { render json: { :now_following => true } , content_type: 'text/json' }
          end

        else

          @following = Following.where(:follower_id => current_predictor.id, :following_id => @predictor.id).first

          @following.update(:active => false)

          @following.save

          respond_to do |format|
            format.js { render json: { :now_following => false } , content_type: 'text/json' }
          end

        end

      end

    end

  end

end