class Game < ActiveRecord::Base

	has_many :predictions

	validates :teama_score, :numericality => { :only_integer => true }
	validates :teamh_score, :numericality => { :only_integer => true }
end
