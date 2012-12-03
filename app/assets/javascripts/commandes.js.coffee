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

  $('#commandes').dataTable(
    sPaginationType: "full_numbers"
  )
  
  # onChange sur le bon de livraison
  $("#commande_bdl_id").change(() ->
    bdlId = $("#commande_bdl_id").val()
    if bdlId isnt ""
      $.getJSON("/commandes/bar/" + bdlId , (data) ->
          $("#commande_client_id").val(data.idClient)
      )
    else
      $("#commande_client_id").val("")
  );
  
  # onChange sur le client : on clean le BdL
  $("#commande_client_id").change(() ->
    $("#commande_bdl_id").val("")
   );