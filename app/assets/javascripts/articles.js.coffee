# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = 'fuckouttahere'
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

   $('form').on 'change', '#article_league_select', (event) ->
   	teams = $('#article_team_select').html()
   	league = $('#article_league_select :selected').text()				
   	$('#test-area').text(league)
   	options = $(teams).filter("optgroup[label='#{league}']").html()
   	if options
   	  $('#article_team_select').html(options)
   	  $('#article_team_select').show()
    else
      $('#article_team_select').empty()
      $('#article_prediction_games_attributes_fuckouttahere_teamh').hide()


   $('form').on 'change', '#article_team_select', (event) ->
   	games = $('#article_game_select').html()
   	team = $('#article_team_select :selected').text()			
   	options = $(games).filter("optgroup[label='#{team}']").html()
   	alert "Stop"
   	if options
   	  $('#article_game_select').html(options)
   	  $('#article_game_select').show()
    else
      $('#article_game_select').empty()
      $('#article_game_select').hide()

   $('form').on 'change', '#article_game_select', (event) ->
   	$('#final-score-select').show()
   	game = $('#article_game_select :selected').val()
   	alert(game)
   	$.ajax
   		url: "/article/league_ajax/#{game}"
   		type: "GET"
   		success: (data) ->
   			console.log(data)