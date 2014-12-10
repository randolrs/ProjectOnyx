class Game < ActiveRecord::Base

	has_many :prediction_games

	belongs_to :sports

	
	#validates :teama_score, :numericality => { :only_integer => true }
	#validates :teamh_score, :numericality => { :only_integer => true }
end
