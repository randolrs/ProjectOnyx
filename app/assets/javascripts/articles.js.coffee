# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

   $('form').on 'change', '.article_league_select', (event) ->
   	teams = $(@).nextAll('.article_team_select').html()
   	league = $(@).val()				
   	$('#test-area').text(league)
   	options = $(teams).filter("optgroup[label='#{league}']").html()
   	if options
   	  $(@).nextAll('.article_team_select').html(options)
   	  $(@).nextAll('.article_team_select').show()
    else
      $(@).nextAll('.article_team_select').empty()
      $(@).nextAll('.article_team_select').hide()


   $('form').on 'change', '.article_team_select', (event) ->
   	gameSelect = $(@).next('.article_game_select')
   	games = gameSelect.html()
   	team = $(@).val()			
   	options = $(games).filter("optgroup[label='#{team}']").html()
   	if options
   	  gameSelect.html(options)
   	  gameSelect.show()
    else
      gameSelect.empty()
      gameSelect.hide()

   $('form').on 'change', '.article_game_select', (event) ->
   	scoreForm = $(@).next('.final-score-select')
   	teamHomeLabel = $(@).next('.final-score-select').children('.team-container').children('.article_prediction_game_teamh')
   	teamAwayLabel = $(@).next('.final-score-select').children('.team-container').children('.article_prediction_game_teama')
   	gameIdInput = $(@).next('.final-score-select').children('.game-id-input')
   	teamHInput = $(@).next('.final-score-select').children('.teamh-input')
   	teamAInput = $(@).next('.final-score-select').children('.teama-input')
   	game = $(@).val()
   	$.ajax
   		url: "/article/league_ajax/#{game}"
   		type: "GET"
   		success: (data) ->
   			console.log(data)
   			teamHomeLabel.text(data.teamh)
   			teamAwayLabel.text(data.teama)
   			scoreForm.slideDown()
   			teamHInput.text(data.teamh)
   			teamAInput.text(data.teama)
   			gameIdInput.val(data.game_id)
   			