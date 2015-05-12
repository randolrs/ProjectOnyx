class Article < ActiveRecord::Base

	belongs_to :predictor

	has_many :prediction_games

	accepts_nested_attributes_for :prediction_games
end
