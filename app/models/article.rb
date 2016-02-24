class Article < ActiveRecord::Base

	belongs_to :predictor

	has_many :prediction_games

	accepts_nested_attributes_for :prediction_games, allow_destroy: true

	def has_topic(topic_id)

		if Tagging.exists?(:article_id => self.id, :tag_id => topic_id)
			return true
		else
			return false
		end

	end
end
