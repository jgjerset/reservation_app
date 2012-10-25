# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#reservation_startdate_proper').datepicker({dateFormat: 'mm-dd-yy'})
  $('#reservation_enddate_proper').datepicker({dateFormat: 'mm-dd-yy'})  
    