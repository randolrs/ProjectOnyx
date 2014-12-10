class Predictor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :prediction_games

def PredictionGame
	@prediction_games = PredictionGame.find(:all, :conditions => ["predictor_id=?",current_predictor.id])
end
end
