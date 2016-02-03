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

   $('form').on 'change', '#article_prediction_games_attributes_fuckouttahere_league', (event) ->
   	teams = $('#article_prediction_games_attributes_fuckouttahere_teamh').html()
   	league = $('#article_prediction_games_attributes_fuckouttahere_league :selected').text()				
   	$('#test-area').text(league)
   	options = $(teams).filter("optgroup[label='#{league}']").html()
   	if options
   	  $('#article_prediction_games_attributes_fuckouttahere_teamh').html(options)
   	  $('#article_prediction_games_attributes_fuckouttahere_teamh').show()
    else
      $('#article_prediction_games_attributes_fuckouttahere_teamh').empty()
      $('#article_prediction_games_attributes_fuckouttahere_teamh').hide()

   $('form').on 'change', '#article_prediction_games_attributes_fuckouttahere_teamh', (event) ->
   	games = $('#article_game_select').html()
   	team = $('#article_prediction_games_attributes_fuckouttahere_teamh :selected').text()			
   	options = $(games).filter("optgroup[label='#{team}']").html()
   	if options
   	  $('#article_game_select').html(options)
   	  $('#article_game_select').show()
    else
      $('#article_game_select').empty()
      $('#article_game_select').hide()

      

