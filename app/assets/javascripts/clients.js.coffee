# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#clients').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#clients').data('source')
    sDom: "<'row'<'span8'l><'span8'f>r>t<'row'<'span8'i><'span8'p>>"
    sWrapper: "dataTables_wrapper form-inline"
    sScrollY: "600px"
