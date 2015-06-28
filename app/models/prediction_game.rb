class PredictionGame < ActiveRecord::Base

		# validates :game_winner, presence: true
		belongs_to :predictor, polymorphic: true

		has_and_belongs_to_many :users
		
		belongs_to :game
		
		belongs_to :article

		def username(predictor_id)
			Predictor.find(predictor_id).username

		end


		def visible(usertype, paid)

			if paid

				if usertype == "user"

				# 	if prediction_game in current_user.prediction_games
				# 		true

				# 	else
				 		false
				# 	end

				elsif usertype == "predictor"

					false

				elsif usertype == "admin"

					true

				elsif usertype == "none"
					false

				else

				# 	if prediction_game in current_predictor.prediction_games
				# 		true

				# 	else
				 		#false
				# 	end

				#else
					false
				end
			else
				true

			end
		end

		#scope :league, -> (league) {where league: league}
		#scope :team, -> (team) {where team: team}
end
