# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('#prediction_game_game_id').parent().hide
	games = $('#prediction_game_game_id').html()
	console.log(games)
	$('#prediction_game_league').change ->
    	league = $('#prediction_game_league :selected').text()
    	options = $(games).filter("optgroup[label='#{league}']").html()
    	if options
    		$('#prediction_game_game_id').html(options)
    		$('#prediction_game_game_id').show()
    	else
    		$('#prediction_game_game_id').empty()

  