# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  jQuery ->

    $(".dismiss-landing-intro").click (event), ->
      event.preventDefault()
      introPanel = $(@).parent('.intro-container')
      introPanel.slideUp()

    $('form').on 'focusin', '.message-text', (event), ->
      publishContainer = $(@).parent().parent().nextAll('.home-publish-container')
      publishButton = $(@).nextAll('.forecast-fields-container').find('.publish-message')
      publishButton.show()
      publishContainer.css("display", "table-row")

    $('form').on 'focusout', '.message-text', (event), ->
      message = $(@).val()
      publishContainer = $(@).parent().parent().nextAll('.home-publish-container')
      publishButton = $(@).nextAll('.forecast-fields-container').find('.publish-message')
      forecastFieldsSummary = $(@).nextAll('.forecast-fields-summary')
      if message.length == 0 && forecastFieldsSummary.find('.forecast-header').text().length == 0
      	publishButton.hide()

    $('form').on 'click', '.forecast-save-button.cancel', (event) ->
      $(@).prev('input[type=hidden]').val('1')
      forecastForm = $(@).parent().parent().parent().parent().parent()
      companyInput = forecastForm.find('.company-input').find('input[type=text], textarea')
      quarterInput = forecastForm.find('.quarter-input').find('.forecast_quarter_select')
      yearInput = forecastForm.find('.year-input').find('.forecast_year_select')
      forecastInput = forecastForm.find('.forecast-input').find('input[type=number]')
      companyInput.val("")
      quarterInput[0].selectedIndex = 0
      yearInput[0].selectedIndex = 0
      forecastInput.val("")
      forecastFieldsSummary = forecastForm.parent().prevAll('.forecast-fields-summary')
      messageText = forecastFieldsSummary.prevAll('.message-text')
      if forecastFieldsSummary.find('.forecast-header').text().length != 0
        forecastFieldsSummary.slideUp()
        forecastFieldsSummary.find('.forecast-header').text("")
        forecastFieldsSummary.find('.forecast-details').text("")
      if $(@).text() == "Remove"
        forecastFieldsSummary.fadeOut()
        forecastForm.hide()
        $(@).prevAll('.forecast-save-button.add').text("Add")
        $(@).text("Cancel")
        if messageText.text().length == 0
          publishButton = forecastForm.nextAll('.publish-message')
          publishButton.hide()
      else
        forecastForm.hide()
        forecastFieldsSummary.hide()
      editForecast = forecastForm.nextAll('.edit-forecast')
      editForecast.show()
      event.preventDefault()

    $('form').on 'click', '.add_fields', (event) ->
      event.preventDefault()
      if $(@).attr('id') == "active"
      	$(@).hide()
      	$(@).prevAll('.home-forecast-form').slideDown()
      else
        $(@).attr('id', 'active')
      	time = new Date().getTime()
      	regexp = new RegExp($(this).data('id'), 'g')
      	$(this).before($(this).data('fields').replace(regexp, time))
      	$(@).hide()

    $('form').on 'click', '.edit-forecast', (event) ->
      event.preventDefault()
      $(@).hide()
      $(@).prevAll('.home-forecast-form').slideDown()

    $('form').on 'click', '.remove_fields', (event) ->
      forecastForm = $(@).parent()
      forecastForm.hide()
      forecastFieldsSummary = forecastForm.parent().prevAll('.forecast-fields-summary')
      if forecastFieldsSummary.find('.forecast-header').text().length == 0
        editForecastButton = forecastForm.nextAll('.edit-forecast')
        editForecastButton.show()
      else
        forecastFieldsSummary.fadeIn()
      event.preventDefault()

    $('form').on 'click', '.forecast-save-button.add', (event) ->
      forecastForm = $(@).parent().parent().parent().parent().parent()
      forecastForm.hide()
      companyInput = forecastForm.find('.company-input').find('input[type=text], textarea').val()
      quarterInput = forecastForm.find('.quarter-input').find(":selected").text()
      yearInput = forecastForm.find('.year-input').find(":selected").text()
      forecastInput = forecastForm.find('.forecast-input').find('input[type=text]').val()
      forecastInputFormatted = parseFloat(forecastInput.replace('$', '')).toFixed(2)
      forecastFieldsSummary = forecastForm.parent().prevAll('.forecast-fields-summary')
      messageTextArea = forecastForm.parent().prevAll('.message-text')
      forecastFieldsSummary.fadeIn()
      forecastSummaryString = "$" + companyInput + " " + quarterInput + " " + yearInput + " $" + forecastInputFormatted
      forecastFieldsSummary.find('.forecast-header').text("EPS Forecast: ")
      forecastFieldsSummary.find('.forecast-details').text(forecastSummaryString)
      $(@).text("Update")
      $(@).nextAll('.forecast-save-button.cancel').text("Remove")
      publishButton = forecastForm.nextAll('.publish-message')
      publishButton.show()
      event.preventDefault()

    $('form').on 'click', '.forecast-fields-summary', (event) ->
      $(@).hide()
      forecastForm = $(@).nextAll('.forecast-fields-container').find('.home-forecast-form')
      forecastForm.slideDown()
      event.preventDefault()