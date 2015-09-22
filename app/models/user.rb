class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :username, uniqueness: {message: "Username is taken"}
         validates :email, uniqueness: {message: "Email is taken"}

  has_many :prediction_games, through: :predictors 
  #has_and_belongs_to_many :predictors
  has_and_belongs_to_many :prediction_games

  has_many :predictors, :through => :purchases

  has_many :purchases


  def my_prediction_games 

    myPurchases = Purchase.all.where(:user_id => self.id)

    predictions = Array.new 

    unless myPurchases.count == 0

      myPurchases.each do |myPurchase|

        predictor = Predictor.find(myPurchase.predictor_id)

        predictor.prediction_games.each do |prediction_game|

          hash = {:prediction=>prediction_game, :predictor=> predictor, :premium_access=> myPurchase.premium}

          predictions << hash

        end
      end
    end
    
    return predictions.sort_by {|k| k[:prediction].created_at}.reverse
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
        
        customer = Stripe::Customer.retrieve(self.customer_id)

        if customer.default_source

          true
        else

          false
        end
      end

    end
end