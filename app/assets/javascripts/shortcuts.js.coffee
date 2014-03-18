# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  # Pagination links.
  $(document).on "click", "#shortcuts_table .pagination a", ->
    $.getScript @href
    false


  # Search form.
  $("#shortcuts_search").submit ->
    $.get @action, $(this).serialize(), null, "script"
    false

  return
