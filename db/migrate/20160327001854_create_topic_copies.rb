class CreateTopicCopies < ActiveRecord::Migration
  def change
    create_table :topic_copies do |t|
      t.string :headline_1
      t.string :headline_2
      t.string :headline_3
      t.integer :topic_id

      t.timestamps
    end
  end
end
