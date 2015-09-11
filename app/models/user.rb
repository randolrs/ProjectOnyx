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
end