class ChangeHeadlineToTopicCopy < ActiveRecord::Migration
  def change

  	change_column :topic_copies, :headline_1, :string, :default => ""
  	change_column :topic_copies, :headline_2, :string, :default => ""
  	change_column :topic_copies, :headline_3, :string, :default => ""
  end
end
