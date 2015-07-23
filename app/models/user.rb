class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :username, uniqueness: {message: "Username is taken"}

         has_many :prediction_games 
         has_and_belongs_to_many :predictors
         has_and_belongs_to_many :prediction_games
    
    def balance_stripe(id)

    Stripe.api_key = User.find(id).account_key_s
    balance_object = Stripe::Balance.retrieve()

    @balance = (balance_object.available[0].amount + balance_object.pending[0].amount)/100
    return @balance


  end
end