class Team < ActiveRecord::Base

	has_many :games
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "50x50>", :default_url => "images/missing.png" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	
	validates :name, presence: true
	validates :league, presence: true
	validates :image, presence: true

end
