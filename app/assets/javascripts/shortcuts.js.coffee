# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  # Pagination links.
  $(document).on "click", ".pagination a", ->
    console.log $(".pagination a")
    $.getScript @href
    false


  # Search form.
  $("#shortcuts_search").submit ->
    $.get @action, $(this).serialize(), null, "script"
    false


  # AJAX to update results as you type
  $("#shortcuts_search input").keyup ->
    $.get $("#shortcuts_search").attr("action"), $("#shortcuts_search").serialize(), null, "script"
    false

  return
