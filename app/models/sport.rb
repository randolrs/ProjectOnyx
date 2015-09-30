class Sport < ActiveRecord::Base

	has_many :teams
	has_many :games

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
						:s3_protocol => :https
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_attached_file :banner_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
						:s3_protocol => :https
	validates_attachment_content_type :banner_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def recent_prediction_games

		myPurchases = Purchase.all.where(:user_id => self.id)

		sport_prediction_games = PredictionGame.all.where(:league=>self.subcat)
		
    	predictions = Array.new 

    	sport_prediction_games.each do |sport_prediction_game|

    		predictor = Predictor.find(sport_prediction_game.predictor_id)

          	hash = {:prediction=>sport_prediction_game, :predictor=> predictor, :premium_access=> false}

          	predictions << hash

        end
    
    	return predictions.sort_by {|k| k[:prediction].created_at}.reverse

	end

end
