class Article < ActiveRecord::Base

	belongs_to :predictor

	has_many :prediction_games

	has_many :taggings

	accepts_nested_attributes_for :prediction_games, allow_destroy: true

	def has_topic(article_id, topic_id)

		if Tagging.where(:article_id => article_id, :tag_id => topic_id).present?
			
			return true

		else
			
			return false

		end

	end

	def recommendation_count

		return Recommendation.all.where(:article_id => self.id, :active => true).count

	end

	def bookmark_count

		return Bookmark.all.where(:article_id => self.id, :active => true).count

	end

	def staff_recommended_articles

		staff_recommended = Array.new

    	recommendations = Recommendation.all.where(:active => true)

    	recommendations.each do |recommendation|

    		if Predictor.find(recommendation.user_id).staff

      			staff_recommended << Article.find(recommendation.article_id)

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
