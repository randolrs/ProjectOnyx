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
end
