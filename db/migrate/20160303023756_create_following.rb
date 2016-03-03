class CreateFollowing < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
  end
end
