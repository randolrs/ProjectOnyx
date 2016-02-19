class AddParentTagToTags < ActiveRecord::Migration
  def change
    add_column :tags, :parent_tag_id, :integer, default: ""
  end
end
