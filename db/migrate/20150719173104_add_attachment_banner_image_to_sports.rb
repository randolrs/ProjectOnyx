class AddAttachmentBannerImageToSports < ActiveRecord::Migration
  def self.up
    change_table :sports do |t|
      t.attachment :banner_image
    end
  end

  def self.down
    remove_attachment :sports, :banner_image
  end
end
