class Predictor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :prediction_games
  has_many :articles
  
  has_many :users, :through => :purchases

  has_many :purchases

  has_attached_file :image, 
    :styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"}, 
    :default_url => 'missing_:style.png',
    :s3_protocol => :https,
    :path => "predictor/default/:style.:extension",
    :bucket => "projectonyx"

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :username, uniqueness: {message: " is taken"}
  validates :email, uniqueness: {message: " is taken"}


	def PredictionGame
		@prediction_games = PredictionGame.find(:all, :conditions => ["predictor_id=?",current_predictor.id])
	end

  def balance_stripe

    if self.account_key_secret

      Stripe.api_key = self.account_key_secret
      balance_object = Stripe::Balance.retrieve()

      balance = (balance_object.available[0].amount)/100

    else

      balance = "N/A"

    end
    
    return balance
  end

  def subscribers_stripe

    if self.account_key_secret
    
      Stripe.api_key = self.account_key_secret

      return Stripe::Customer.all.count
    else

      return 0
    end

  end

  def charges_stripe

    if self.account_key_secret

      Stripe.api_key = self.account_key_secret

      return Stripe::Charge.all

    end

  end

  def active_prediction_count

    return self.prediction_games.where(:status => "o").count

  end

  def rated_prediction_count

    return self.prediction_games.where(:status => "c").count

  end

  
  def my_prediction_games_upcoming(premium_access)

    predictor = self

    predictions = Array.new 

    predictor = self

    predictor.prediction_games.each do |prediction_game|

      if prediction_game.event_time > Time.now

        hash = {:prediction=>prediction_game, :predictor=> predictor}

        predictions << hash

      end

    end
    
    return predictions.sort_by {|k| k[:prediction].event_time}

  end

  def my_prediction_games_closed(premium_access)

    predictor = self

    predictions = Array.new 

    predictor.prediction_games.each do |prediction_game|

      if prediction_game.status == "c"

        hash = {:prediction=>prediction_game, :predictor=> predictor, :premium_access=> premium_access}

        predictions << hash

      end

    end
    
    return predictions.sort_by {|k| k[:prediction].onyx}

  end

  def recent_prediction_games(premium_access)

    predictions = Array.new 
    
    self.prediction_games.each do |prediction_game|

      hash = {:prediction=>prediction_game, :predictor=>self, :premium_access=> premium_access}

      predictions << hash

    end  
    
    return predictions.sort_by {|k| k[:prediction].created_at}.reverse

  end

  def sub_price

    if self.subscription_id

      Stripe.api_key = self.account_key_secret

      predictor_plans = Stripe::Plan.all

      active = false

      predictor_plans.each do |plan|

        if plan.id == self.subscription_id
          active = true
        end

      end

      if active

        current_plan = Stripe::Plan.retrieve(self.subscription_id)

        return current_plan.amount / 100

      else

        return "Error"
      end

    else

      return "N/A"
    end

  end

  def transfers_enabled

    if self.account_id

      Stripe.api_key = Rails.configuration.stripe[:secret_key]

      account = Stripe::Account.retrieve(self.account_id)

      if account.transfers_enabled == true && account.external_accounts.total_count > 0

        return true

      else

        return false

      end

    else

      return false

    end

  end

end
