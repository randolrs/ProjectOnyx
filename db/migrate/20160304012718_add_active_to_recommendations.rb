class AddActiveToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :active, :boolean, default: true
  end
end
