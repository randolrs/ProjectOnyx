class AddActiveToFollowing < ActiveRecord::Migration
  def change
    add_column :followings, :active, :boolean, default: true
  end
end
