# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
  $('.datepicker').datepicker({"autoclose": true, "format": "dd/mm/yyyy", defaultDate:+0}) 
  $('.hidden').hide()

  $('#commande_is_livraison').change ->
    inverse('commande_date_livraison')
    
  if ($('#commande_is_livraison').is(":checked"))
    show('commande_date_livraison')
     
  $('#commande_is_paiement').change ->
    inverse('commande_date_paiement')
    
  if ($('#commande_is_paiement').is(":checked"))
    show('commande_date_paiement')
