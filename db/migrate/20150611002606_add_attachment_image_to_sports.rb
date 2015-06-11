class AddAttachmentImageToSports < ActiveRecord::Migration
  def self.up
    change_table :sports do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :sports, :image
  end
end
