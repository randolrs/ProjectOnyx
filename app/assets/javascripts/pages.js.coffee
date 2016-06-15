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
      forecastForm.nextAll('.add_fields').show()
      forecastForm.parent().prevAll('.forecast-fields-summary').slideDown()
      event.preventDefault()