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
    :s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :username, uniqueness: {}
  validates :email, uniqueness: {}


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

  def rated_predictions

    predictions = Array.new 
    
    self.prediction_games.where("onyx IS NOT NULL").each do |prediction_game|

      if prediction_game.status = "c"

        hash = {:prediction=>prediction_game, :predictor=>self, :game=> Game.find(prediction_game.game_id)}

        predictions << hash

      end

    end

    return predictions.sort_by {|k| k[:prediction].created_at}.reverse

  end

  def onyx_rating

    return self.prediction_games.where("onyx IS NOT NULL").average(:onyx)

  end

  def onyx_rating_category

    rating = self.prediction_games.where("onyx IS NOT NULL").average(:onyx)

    hash = Array.new

    if rating > 0

      if rating < 20

        hash = {:rating_string=>"Terrible", :style_code => "background-color:#F02414;"}

      elsif rating < 40

        hash = {:rating_string=>"Unreliable", :style_code => "background-color:#F05B1B;"}

      elsif rating < 60

        hash = {:rating_string=>"Questionable", :style_code => "background-color:#F0CC1F;"}

      elsif rating < 80

        hash = {:rating_string=>"Reliable", :style_code => "background-color:#05BA28;"}

      else

        hash = {:rating_string=>"Superlative", :style_code => "background-color:#8210A1; color:#FFBC19"}

      end
        
    else

      hash = {:rating_string=>"Unrated", :color_code=> "#666"}

    end

    return hash

  end

  def league_predictions(league)

    return self.prediction_games.where(:league => league)

  end

  def team_predictions(team)

    return self.prediction_games.where("teama = :team or teamh = :team", {team: team.name})

  end

  def sport_predictions_rating(league)

    sport = Sport.find_by_subcat(league)

    predictions = self.prediction_games.where("onyx IS NOT NULL")

    if predictions.count > 0

      return  (predictions.collect(&:onyx).sum / predictions.count).to_i

    else

      return "N/A"
    end

  end

  def team_predictions_rating(team)

    predictions = self.prediction_games.where("(teama = :team or teamh = :team) and onyx IS NOT NULL", {team: team.name})

    if predictions.count > 0

      return  (predictions.collect(&:onyx).sum / predictions.count).to_i

    else

      return "N/A"
    end

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

  def recent_prediction_games

    predictions = Array.new 
    
    self.prediction_games.each do |prediction_game|

      if prediction_game.game_id

        hash = {:prediction=>prediction_game, :predictor=>self, :game=> Game.find(prediction_game.game_id)}

        predictions << hash

      end

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

        return 5
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

  def recommendations
   
    return Recommendation.where(:user_id => self.id, :active => true)

  end


  def has_recommendation_inactive(article_id)

    if Recommendation.where(:article_id => article_id, :user_id => self.id, :active => false).present?
      
      return true

    else
      
      return false

    end

  end

  def has_recommendation_active(article_id)

    if Recommendation.where(:article_id => article_id, :user_id => self.id, :active => true).present?
      
      return true

    else
      
      return false

    end

  end

  def has_follower_inactive(follower_id)

    if Following.where(:follower_id => follower_id, :following_id => self.id, :active => false).present?
      
      return true

    else
      
      return false

    end 

  end

  def has_follower_active(follower_id)

    if Following.where(:follower_id => follower_id, :following_id => self.id, :active=> true).present?
      
      return true

    else
      
      return false

    end 

  end

  def has_bookmark_active(article_id)

    if Bookmark.where(:user_id => self.id, :article_id => article_id, :active=> true).present?
      
      return true

    else
      
      return false

    end 

  end

  def has_bookmark_inactive(article_id)

    if Bookmark.where(:user_id => self.id, :article_id => article_id, :active=> false).present?
      
      return true

    else
      
      return false

    end 

  end

  def bookmarked_articles

    article_bookmarks = Array.new

    bookmarks = Bookmark.all.where(:user_id => self.id, :active => true)

    bookmarks.each do |bookmark|

      article_bookmarks << Article.find(bookmark.article_id)

    end

    return article_bookmarks

  end

  def followers

    return Following.where(:following_id => self.id, :active => true)

  end

  def followings

    return Following.where(:follower_id => self.id, :active => true)

  end

end
