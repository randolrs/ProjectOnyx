class AddDefaultPriceToPredictionGames < ActiveRecord::Migration
  def change
  	  	def up
  		change_column :prediction_games, :cost, :decimal, :precision => 8, :scope => 2, :default => 0
	end

	def down
  		change_column :prediction_games, :cost, :decimal, :precision => 8, :scope => 2, default: nil
	end
  end
end
