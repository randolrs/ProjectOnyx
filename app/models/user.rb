class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: {message: "Email is taken"}

  has_many :prediction_games, through: :predictors 
  #has_and_belongs_to_many :predictors
  has_and_belongs_to_many :prediction_games

  has_many :predictors, :through => :purchases

  has_many :purchases


  def my_predictors

    myPurchases = Purchase.all.where(:user_id => self.id, :active=> true)

    predictors = Array.new 

    myPurchases.each do |myPurchase|

      if myPurchase.predictor_id
        
        predictor = Predictor.find(myPurchase.predictor_id)

        predictors << predictor

      end  
              
    end

    return predictors

  end

  def my_subscriptions

    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    myPurchases = Purchase.all.where(:user_id => self.id, :premium => true, :active=> true)

    predictors = Array.new 

    myPurchases.each do |myPurchase|

      if myPurchase.predictor_id

      predictor = Predictor.find(myPurchase.predictor_id)

        if predictor.account_key_secret

          Stripe.api_key = predictor.account_key_secret

          stripe_predictor = Stripe::Account.retrieve(predictor.account_id)

          stripe_customers = Stripe::Customer.all

          stripe_customers.each do |stripe_customer|

            if stripe_customer.description.to_s == self.id.to_s

              predictors << predictor

            end

          end

        end

      end

    end

    return predictors

  end

  def my_prediction_games 

    ###need to use stripe authentication for premium, using two other methods

    #create predictors array

    predictors = Array.new

    self.my_subscriptions.each do |predictor_subscription|

      hash = {:predictor=> predictor_subscription, :premium=>true}

      predictors << hash

    end

    self.my_predictors.each do |predictor_follow|

      hash = {:predictor=> predictor_follow, :premium=>false}

      predictors << hash

    end

    predictors = predictors.uniq { |s| s.first }

    predictions = Array.new 

    unless predictors.count == 0

      predictors.each do |predictor|

        predictor_object = predictor[:predictor]

        predictor_object.prediction_games.each do |prediction_game|

          hash = {:prediction=>prediction_game, :predictor=> predictor[:predictor], :premium_access=> predictor[:premium]}

          predictions << hash

        end

      end

    end

    predictions = predictions.uniq 
    
    return predictions.sort_by {|k| k[:prediction].created_at}.reverse

  end

  def my_prediction_games_recent

  end

  def my_prediction_games_upcoming

    myPurchases = Purchase.all.where(:user_id => self.id)

    predictions = Array.new 

    unless myPurchases.count == 0

      myPurchases.each do |myPurchase|

        predictor = Predictor.find(myPurchase.predictor_id)

        predictor.prediction_games.each do |prediction_game|

          if prediction_game.event_time > Time.now

          hash = {:prediction=>prediction_game, :predictor=> predictor, :premium_access=> myPurchase.premium}

          predictions << hash

          end

        end
      end
    end
    
    return predictions.sort_by {|k| k[:prediction].event_time}

  end

  def my_prediction_games_closed

    myPurchases = Purchase.all.where(:user_id => self.id)

    predictions = Array.new 

    unless myPurchases.count == 0

      myPurchases.each do |myPurchase|

        predictor = Predictor.find(myPurchase.predictor_id)

        predictor.prediction_games.each do |prediction_game|

          if prediction_game.status == "c"

          hash = {:prediction=>prediction_game, :predictor=> predictor, :premium_access=> myPurchase.premium}

          predictions << hash

          end

        end
      end
    end
    
    return predictions.sort_by {|k| k[:prediction].event_time}

  end

  def my_prediction_games_top

  end

  def my_purchases

    Purchase.all.where(:user_id => self.id)

  end 

  def my_sidebar_games 
    
    Game.all.where("event_time > :today", {today: Time.now}).order("created_at DESC").limit(3)
          
  end

  def subscribed(predictor_id)

    if Purchase.exists?(:user_id=> self.id,:predictor_id=>predictor_id, :premium=>true)

      true

    else

      false

    end

  end

  def follow(predictor_id)

    if Purchase.exists?(:user_id=> self.id,:predictor_id=>predictor_id)

      true

    else

      false

    end

  end


  def balance_stripe(id)

    if User.find(id).account_key_s

      Stripe.api_key = User.find(id).account_key_s
      balance_object = Stripe::Balance.retrieve()

      @balance = (balance_object.available[0].amount + balance_object.pending[0].amount)/100
      
    else

      @balance = 0
      
    end

    return @balance

  end

  def paymentsource
    
    if Stripe.api_key = Rails.configuration.stripe[:secret_key]

      if self.customer_id
      
        customer = Stripe::Customer.retrieve(self.customer_id)

        if customer.default_source

          true
        else

          false
        end

      else

        false
      end
      
    end

  end


end