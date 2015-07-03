class Predictor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :prediction_games
  has_many :articles

  has_attached_file :image, 
    :styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"}, 
    :default_url => 'missing_:style.png',
    :path => "predictor/default/:style.:extension",
    :bucket => "projectonyx"

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :username, uniqueness: {message: "Username is taken"}


	def PredictionGame
		@prediction_games = PredictionGame.find(:all, :conditions => ["predictor_id=?",current_predictor.id])
	end

  def balance_stripe(account_token)

    Stripe.api_key = account_token
    balance_object = Stripe::Balance.retrieve()

    @balance = balance_object.available[0].amount
    return @balance


  end

end
