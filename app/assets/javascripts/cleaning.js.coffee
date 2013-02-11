# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#cleaning').dataTable(
    sPaginationType: "full_numbers"
    aaSorting: [[ 0, "asc" ]]
    aoColumns: [                                                                 
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": false}
      ]
    bJQueryUI: true
    bProcessing: true
    bServerSide: true      
    sAjaxSource: $('#cleaning').data('source')  
  )

  $("#client_nom").change ->
    $("#client_nom").val($("#client_nom").val().toUpperCase())    
