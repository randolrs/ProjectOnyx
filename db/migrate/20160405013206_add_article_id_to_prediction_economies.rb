class AddArticleIdToPredictionEconomies < ActiveRecord::Migration
  def change
    add_column :prediction_economies, :article_id, :integer
  end
end
