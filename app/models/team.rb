class Team < ActiveRecord::Base

	has_many :games
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "50x50>", :default_url => "images/missing.png" },
						:s3_protocol => :https
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	
	validates :name, presence: true
	validates :league, presence: true
	validates :image, presence: true

	def recent_prediction_games 

        predictions = Array.new 

        team = Team.find(self.id)

        prediction_games = PredictionGame.all.where("teama = :team or teamh = :team", {team: team.name})

        prediction_games.each do |prediction|

        	predictor = Predictor.find(prediction.predictor_id)

            hash = {:prediction=>prediction, :predictor=> predictor, :premium_access=> false}

            predictions << hash
          
        end
        
        return predictions.sort_by {|k| k[:prediction].created_at}.reverse
      end

    def upcoming_games

        games = Array.new 

        team = Team.find(self.id)

        team_games = Game.all.where(" event_time > :time_now and (teama = :team or teamh = :team)", {team: team.name, time_now: Time.now})

        team_games.each do |team_game|

            games << team_game
          
        end
        
        return games.sort_by {|k| k.event_time}.reverse        

    end

end
