class Sport < ActiveRecord::Base

	has_many :teams
	has_many :games

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
						:s3_protocol => :https
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_attached_file :banner_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
						:s3_protocol => :https
	validates_attachment_content_type :banner_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


end
