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


	def PredictionGame
		@prediction_games = PredictionGame.find(:all, :conditions => ["predictor_id=?",current_predictor.id])
	end

  def balance_stripe(id)

    Stripe.api_key = Predictor.find(id).account_key_secret
    balance_object = Stripe::Balance.retrieve()

    @balance = (balance_object.available[0].amount + balance_object.pending[0].amount)/100
    
    return @balance
  end


  

  def my_prediction_games_upcoming(premium_access)

    predictor = self

    predictions = Array.new 

    predictor = self

    predictor.prediction_games.each do |prediction_game|

      if prediction_game.event_time > Time.now

        hash = {:prediction=>prediction_game, :predictor=> predictor, :premium_access=> premium_access}

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

end
