# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $('form').on 'click', '.remove_fields', (event) ->
    $(@).prev('input[type=hidden]').val('1')
    $(@).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

   $('form').on 'change', '.article_league_select', (event) ->
   	teams = $(@).nextAll('.article_team_select').html()
   	teams_default = $(@).nextAll('.article_team_select_default').html()
   	league = $(@).val()				
   	options = $(teams_default).filter("optgroup[label='#{league}']").html()
   	if options
   	  $(@).nextAll('.article_team_select').html(options)
   	  $(@).nextAll('.article_team_select').show()
    else
      $(@).nextAll('.article_team_select').empty()
      $(@).nextAll('.article_team_select').hide()

   $('form').on 'change', '.article_team_select', (event) ->
   	games = $(@).nextAll('.article_game_select').html()
   	gameSelect = $(@).nextAll('.article_game_select')
   	games_default = $(@).nextAll('.article_game_select_default').html()
   	team = $(@).val()
    options = $(games_default).filter("optgroup[label='#{team}']").html()
   	if options
   	  gameSelect.html(options)
   	  gameSelect.show()
    else
      gameSelect.empty()
      gameSelect.hide()

   $('form').on 'change', '.article_game_select', (event) ->
   	scoreForm = $(@).nextAll('.final-score-select')
   	teamHomeLabel = scoreForm.children('.team-container').children('.article_prediction_game_teamh')
   	teamAwayLabel = scoreForm.children('.team-container').children('.article_prediction_game_teama')
    leagueInput = scoreForm.children('.league-input')
   	gameIdInput = scoreForm.children('.game-id-input')
   	teamHInput = scoreForm.children('.teamh-input')
   	teamAInput = scoreForm.children('.teama-input')
   	eventTimeInput = scoreForm.children('.event-time-input')
   	game = $(@).val()
   	$.ajax
   		url: "/article/ajax_league/#{game}"
   		type: "GET"
   		success: (data) ->
   			console.log(data)
   			teamHomeLabel.text(data.teamh)
   			teamAwayLabel.text(data.teama)
   			teamHInput.val(data.teamh)
   			teamAInput.val(data.teama)
   			eventTimeInput.val(data.event_time)
   			gameIdInput.val(data.game_id)
   			scoreForm.slideDown()

   			