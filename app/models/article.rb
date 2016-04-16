class Article < ActiveRecord::Base

	belongs_to :predictor

	has_many :prediction_games

	has_many :prediction_economies

	has_many :taggings

	accepts_nested_attributes_for :prediction_games, allow_destroy: true

	accepts_nested_attributes_for :prediction_economies, allow_destroy: true

	def has_topic(article_id, topic_id)

		if Tagging.where(:article_id => article_id, :tag_id => topic_id).present?
			
			return true

		else
			
			return false

		end

	end

	def bookmark_count

		return Bookmark.all.where(:article_id => self.id, :active => true).count

	end

	def recommendation_count

		return Recommendation.all.where(:article_id => self.id, :active => true).count

	end

	def recommendation_count_week

		#return Recommendation.all.where(:article_id => self.id, :active => true).count

		time_week = Time.now - 60*60*24*7 #time is in seconds, 60 seconds times 60 minutes times 24 hours times 7 days

		return Recommendation.all.where("article_id = :article_id and active = :active and created_at > :time_week", {article_id: self.id, active: true, time_week: time_week }).count
          

	end

	def recommended_by_user_I_follow(current_user_id)

		recommendations = Recommendation.all.where(:article_id => self.id, :active => true)

		follows = Following.all.where(:follower_id => current_user_id)

		recommender_followers = Array.new

		recommendations.each do |recommendation|

			follows.each do |follow|

				if follow.following_id == recommendation.user_id and not recommendation.user_id == self.predictor_id

					recommender = Predictor.find(recommendation.user_id)
					hash = {:recommender => recommender, :followers => recommender.followers.count}
					recommender_followers << hash
					
				end

			end

		end

		unless recommender_followers.empty?

			recommender_followers.sort_by {|k| k[:followers]}

			return recommender_followers.first[:recommender]

		else

			return nil

		end

	end


	def recommended_by_staff

    	recommendations = Recommendation.all.where(:active => true, :article_id => self.id)

    	staff_recommended = false

    	recommendations.each do |recommendation|

    		if Predictor.find(recommendation.user_id).staff

      			staff_recommended = true

      		end

    	end 

    	return staff_recommended

    	#return Article.all

	end

	def staff_recommendations

		staff_recommendations = Array.new

		recommendations = Recommendation.all.where(:article_id => self.id, :active => true)

		recommendations.each do |recommendation|

			predictor = Predictor.find(recommendation.user_id)

			if predictor.staff

				staff_recommendations << predictor

			end

		end

		return staff_recommendations

	end

end
