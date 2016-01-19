class PredictionGame < ActiveRecord::Base

		# validates :game_winner, presence: true
		belongs_to :predictor, polymorphic: true

		has_and_belongs_to_many :users
		
		belongs_to :game
		
		belongs_to :article

		def username(predictor_id)
			
			Predictor.find(predictor_id).username

		end

		def visible(usertype, access)

			predictor_id = self.predictor_id

			if self.paid

				unless self.onyx

					if usertype == "user"

						###add stripe authentication, or base on method of

						if Purchase.exists?(:user_id => access.id, :predictor_id => predictor_id, :premium => true)

							true
						else

							false
						end

					elsif usertype == "predictor"

						if access.prediction_games.exists?(:id => id)
							true

						else
					 		false
						end

					elsif usertype == "admin"
						true

					elsif usertype == "none"
						false

					else
						false
					end
				else
					true
				end

			else
				true

			end
		end

		#scope :league, -> (league) {where league: league}
		#scope :team, -> (team) {where team: team}
end
