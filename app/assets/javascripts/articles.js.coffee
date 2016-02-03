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
      $('#article_prediction_games_attributes_fuckouttahere_teamh').show()
   	  $('#article_prediction_games_attributes_fuckouttahere_teamh').html(options)
    else
      $('#article_prediction_games_attributes_fuckouttahere_teamh').hide()
      $('#article_prediction_games_attributes_fuckouttahere_teamh').empty()
      


    


  $('#team_select').parent().hide()
  teams = $('#person_state_id').html()
  $('#person_country_id').change ->
    country = $('#person_country_id :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(states).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#person_state_id').html(options)
      $('#person_state_id').parent().show()
    else
      $('#person_state_id').empty()
      $('#person_state_id').parent().hide()
