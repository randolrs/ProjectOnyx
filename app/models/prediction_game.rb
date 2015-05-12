class PredictionGame < ActiveRecord::Base

		# validates :game_winner, presence: true
		belongs_to :predictor, polymorphic: true

		has_and_belongs_to_many :users
		
		belongs_to :game
		
		belongs_to :article

		#scope :league, -> (league) {where league: league}
		#scope :team, -> (team) {where team: team}
end
