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

        team_games = Game.all.where("event_time > :time_now and (teama = :team or teamh = :team)", {team: team.name, time_now: Time.now})

        team_games.each do |team_game|

            games << team_game
          
        end
        
        return games.sort_by {|k| k.event_time}       

    end

    def all_games

        games = Array.new

        team = self

        team_games = Game.all.where("(teama = :team or teamh = :team)", {team: team.name})

        team_games.each do |team_game|

            if team_game.teamh == team.name

                home = true

            else

                home = false

            end
                    

            hash = {:game=>team_game, :home=> home}

            games << hash
          
        end

        return games.sort_by {|k| k[:game].event_time} 

    end


    def all_predictors

        predictors = Array.new

        team = self

        team_predictors = Predictor.all

        team_predictors.each do |team_predictor|

            if team_predictor.prediction_games.all.where("teama = :team or teamh = :team", {team: team.name}).count > 0

                predictors << team_predictor

            end
          
        end

        return predictors

    end

    def schedule_games(season)


        return Game.where("league = :league and (teama = :team or teamh = :team) and season = :season", {league: self.league, team: self.name, season: season}).sort_by {|k| k.event_time}


    end

end
