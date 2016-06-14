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
      if $(@).attr('id') == "active"
      	$(@).hide()
        $(@).prevAll('.home-forecast-form').slideDown()
      else
        $(@).attr('id', 'active')
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        publishContainer = $(@).nextAll('.home-publish-container')
        publishContainer.css("display", "table-row")
        $(@).hide()
      event.preventDefault()

    $('form').on 'click', '.remove_fields', (event) ->
      $(@).prev('input[type=hidden]').val('1')
      $(@).parent().sllideUp()
      $(@).parent().nextAll('.add_fields').show()
      homePublishContainer = $(@).parent().nextAll('.home-publish-container')
      messageText = homePublishContainer.parent().find('.home-message-container').children('.home-message').children('.message-text').val()
      if messageText == ""
        homePublishContainer.slideUp()
      event.preventDefault()
      
