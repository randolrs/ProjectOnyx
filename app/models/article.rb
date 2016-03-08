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

end
