class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :username, uniqueness: {message: "Username is taken"}

         has_many :prediction_games 
         has_and_belongs_to_many :predictors
         has_and_belongs_to_many :prediction_games
end