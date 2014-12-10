class PredictionGame < ActiveRecord::Base

		# validates :game_winner, presence: true
		belongs_to :predictor
		belongs_to :game
end
