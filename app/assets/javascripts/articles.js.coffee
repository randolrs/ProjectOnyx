# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  jQuery ->

    $('form').on 'click', '.remove_fields', (event) ->
      $(@).prev('input[type=hidden]').val('1')
      $(@).closest('fieldset').hide()
      event.preventDefault()

    $('form').on 'click', '.add_fields', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      publishContainer = $(@).nextAll('.home-publish-container')
      publishContainer.css("display", "table-row")
      $(@).hide()
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
    
     $('form').on 'change', '.article_country_select', (event) ->
      timeContainer = $(@).nextAll('.article_time_select_container')
      timeContainer.hide()
      indicatorContainer = $(@).nextAll('.article_indicator_select_container')
      indicatorSelect = indicatorContainer.children('.article_indicator_select')
      indicatorDefault = indicatorContainer.children('.article_indicator_select_default')
      indicators = indicatorSelect.html()
      indicators_default = indicatorDefault.html()
      country = $(@).val()
      options = $(indicators_default).filter("optgroup[label='#{country}']").html()
      if options
        indicatorSelect.html(options)
        indicatorContainer.slideDown()
      else
        indicatorSelect.empty()
        indicatorContainer.hide()

     $('form').on 'change', '.article_indicator_select', (event) ->
      timeContainer = $(@).parent().nextAll('.article_time_select_container')
      timeSelect = timeContainer.children('.article_time_select')
      timeDefault = timeContainer.children('.article_time_select_default')
      times = timeSelect.html()
      times_default = timeDefault.html()
      indicator = $(@).val()
      country = $(@).parent().prevAll('.article_country_select').val()
      country_indicator_string = country + " " + indicator
      options = $(times_default).filter("optgroup[label='#{country_indicator_string}']").html()
      if options
        timeSelect.html(options)
        timeContainer.slideDown()
      else
        timeSelect.empty()
        timeContainer.hide()

    $('form').on 'change', '.article_time_select', (event) ->
      priceForm = $(@).parent().nextAll('.price-select')
      indicatorLabel = priceForm.children('.article_prediction_economy_indicator')
      typeIdInput = priceForm.children('.type-id-input')
      typeId = $(@).val()
      $.ajax
        url: "/article/ajax_indicator/#{typeId}"
        type: "GET"
        success: (data) ->
          console.log(data)
          indicatorString = data.country + " " + data.sub_category + " " + data.strike_description + " Prediction:"
          indicatorLabel.text(indicatorString)
          typeIdInput.val(data.type_id)
          priceForm.slideDown()

    $('form').on 'click', '.prediction-save-button', (event), ->
      priceForm = $(@).parent().parent()
      indicatorLabel = priceForm.children('.article_prediction_economy_indicator')
      predictionInput = priceForm.children('.article_prediction_economy_prediction')
      predictionFilterContainer = $(@).parent().parent().parent()
      predictionSummaryContainer = $(@).parent().parent().parent().prevAll('.article-prediction-summary')
      predictionSummaryLabel = predictionSummaryContainer.children('.article_prediction_economy_indicator_summary')
      predictionSummaryString = indicatorLabel.text() + " " + predictionInput.val()
      predictionSummaryLabel.text(predictionSummaryString)
      predictionFilterContainer.slideUp()
      predictionSummaryContainer.slideDown()

    $('form').on 'click', '.edit-prediction', (event), ->
      predictionFilterContainer = $(@).parent().nextAll('.article-prediction-filters')
      predictionSummaryContainer = $(@).parent()
      predictionSummaryContainer.slideUp()
      predictionFilterContainer.slideDown()

    $('form').on 'click', '.remove_fields', (event) ->
      $(@).prev('input[type=hidden]').val('1')
      $(@).parent().hide()
      $(@).parent().nextAll('.add_fields').show()
      homePublishContainer = $(@).parent().nextAll('.home-publish-container')
      messageText = homePublishContainer.parent().find('.home-message-container').children('.home-message').children('.message-text').val()
      if messageText == ""
        homePublishContainer.slideUp()
      event.preventDefault()

    $(".recommend-button").click (event), ->
      event.preventDefault()
      $recommend_button = $(this)
      $recommend_count = $(this).nextAll('.recommend-button.count')
      $recommend_count_value = parseInt($recommend_count.html(),10)
      $article_id = $recommend_button.attr 'id'
      $.ajax
        url: "/article/recommend/#{$article_id}"
        type: "GET"
        success: (data) ->
          console.log(data)
          if data.now_recommending
            $recommend_button.addClass('recommended')
            $newValue = $recommend_count_value + 1
            $recommend_count.text($newValue)
          else
            $recommend_button.removeClass('recommended')
            $newValue = $recommend_count_value - 1
            $recommend_count.text($newValue)

    $(".bookmark-button").click (event), ->
      event.preventDefault()
      $bookmark_button = $(this)
      $article_id = $bookmark_button.attr 'id'
      $.ajax
        url: "/article/bookmark/#{$article_id}"
        type: "GET"
        success: (data) ->
          console.log(data)
          if data.now_bookmarked
            $bookmark_button.addClass('bookmarked')
          else
            $bookmark_button.removeClass('bookmarked')

    $(".follow-button").click (event), ->
      event.preventDefault()
      $following_button = $(this)
      $following_id = $following_button.attr 'id'
      $.ajax
        url: "/predictor/follow/#{$following_id}"
        type: "GET"
        success: (data) ->
          console.log(data)
          if data.now_following
            $following_button.addClass('following')
            $following_button.text("Following")
          else
            $following_button.removeClass('following')
            $following_button.text("Follow")

   			