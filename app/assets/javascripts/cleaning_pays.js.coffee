# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#cleaning-pays').dataTable(
    sPaginationType: "full_numbers"
    aoColumns: [                                                                 
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
      ]    
    bJQueryUI: true
    bProcessing: true
    bServerSide: true      
    sAjaxSource: $('#cleaning-pays').data('source')
  )  