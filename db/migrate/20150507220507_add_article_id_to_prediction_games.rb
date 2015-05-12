class AddArticleIdToPredictionGames < ActiveRecord::Migration
  def change
    add_column :prediction_games, :article_id, :integer
  end
end
