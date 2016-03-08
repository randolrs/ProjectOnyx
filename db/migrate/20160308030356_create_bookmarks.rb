class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :article_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
