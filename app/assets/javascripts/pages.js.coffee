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
      forecastContainer = $(@).parent().parent().parent().find('.home-forecast-form').css('display')
      if message == "" && forecastContainer != "block"
      	publishContainer.slideUp()
      	publishButton.show()

    $('form').on 'click', '.forecast-save-button.cancel', (event) ->
      $(@).prev('input[type=hidden]').val('1')
      forecastForm = $(@).parent().parent().parent().parent().parent()
      forecastForm.slideUp()
      forecastForm.nextAll('.add_fields').show()
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

    $('form').on 'click', '.remove_fields', (event) ->
      $(@).prev('input[type=hidden]').val('1')
      forecastForm = $(@).parent()
      forecastForm.slideUp()
      forecastForm.nextAll('.add_fields').show()
      event.preventDefault()

    $('form').on 'click', '.forecast-save-button.add', (event) ->
      forecastForm = $(@).parent().parent().parent().parent().parent()
      forecastForm.slideUp()
      forecastInputs = forecastForm.find('.company-quarter-year-cell')
      companyInput = forecastForm.find('.company-input').find('input[type=text], textarea').val()
      quarterInput = forecastForm.find('.quarter-input').find(":selected").text()
      forecastInput = forecastForm.find('.forecast-input').find('input[type=number]').val()
      yearInput = forecastForm.find('.year-input').find(":selected").text()
      forecastForm.nextAll('.add_fields').show()
      forecastFieldsSummary = forecastForm.parent().prevAll('.forecast-fields-summary')
      messageTextArea = forecastForm.parent().prevAll('.message-text')
      forecastFieldsSummary.slideDown()
      messageTextArea.text("Hello")
      alert(forecastInput)
      forecastSummaryString = "EPS Forecast $" + companyInput + " " + quarterInput + " " + yearInput + " " + forecastInput
      alert(companyInput)
      alert(quarterInput)
      alert(yearInput)
      forecastFieldsSummary.text(forecastSummaryString)
      event.preventDefault()