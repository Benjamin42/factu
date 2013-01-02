# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#clients').dataTable(
    sPaginationType: "full_numbers"
    "aoColumns": [                                                                 
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": false}
       { "bSortable": false}
       { "bSortable": false}
       { "bSortable": false}
       { "bSortable": false}
      ]    
  )
  
