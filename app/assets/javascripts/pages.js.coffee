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
      publishButton.slideDown()
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
      forecastForm.hide()
      forecastForm.nextAll('.add_fields').show()
      homePublishContainer = $(@).parent().nextAll('.home-publish-container')
      messageText = homePublishContainer.parent().find('.home-message-container').children('.home-message').children('.message-text').val()
      if messageText == ""
        homePublishContainer.slideUp()
      event.preventDefault()
      
