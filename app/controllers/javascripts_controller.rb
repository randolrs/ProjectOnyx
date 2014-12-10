class JavascriptsController < ApplicationController
	
	def dynamic_games
    	@games = Game.all
  	end

end
