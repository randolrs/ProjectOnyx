class AddPredictorIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :predictor_id, :integer
  end
end
