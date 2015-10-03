class Game < ActiveRecord::Base

	has_many :prediction_games

	belongs_to :sports

	belongs_to :teams

	def recent_prediction_games

		game_prediction_games = PredictionGame.all.where(:game_id=>self.id)
		
    	predictions = Array.new 

    	game_prediction_games.each do |game_prediction_game|

    		predictor = Predictor.find(game_prediction_game.predictor_id)

          	hash = {:prediction=>game_prediction_game, :predictor=> predictor, :premium_access=> false}

          	predictions << hash

        end
    
    	return predictions.sort_by {|k| k[:prediction].created_at}.reverse

	end

	def other_games

		team_games = Game.all.where("event_time > :time_now and (teama = :teama or teamh = :teama or teama = :teamh or teamh = :teamh)", {teama: self.teama, teamh: self.teamh, time_now: Time.now})
		
    	games = Array.new 

    	team_games.each do |game|

          	games << game

        end
    
    	return games.sort_by {|k| k.event_time}

	end

	
	#validates :teama_score, :numericality => { :only_integer => true }
	#validates :teamh_score, :numericality => { :only_integer => true }
end
