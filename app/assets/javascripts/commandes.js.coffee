# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
  $('.datepicker').datepicker({"autoclose": true, "format": "dd/mm/yyyy", defaultDate:+0}) 
  $('.hidden').hide()

  $('#commande_is_livraison').change ->
    inverseDate('commande_date_livraison')
    
  if ($('#commande_is_livraison').is(":checked"))
    show('commande_date_livraison')
     
  $('#commande_is_paiement').change ->
    inverseDate('commande_date_paiement')
    
  if ($('#commande_is_paiement').is(":checked"))
    show('commande_date_paiement')

  $('#commandes').dataTable(
    sPaginationType: "full_numbers"
    "aoColumns": [                                                                 
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
      ]  
  )
  
  # onChange sur le bon de livraison
  $("#commande_bdl_id").change(() ->
    bdlId = $("#commande_bdl_id").val()
    if bdlId isnt ""
      $.getJSON("/commandes/bar/" + bdlId , (data) ->
          $("#commande_client_id").val(data.idClient)
          
          tabStock = "Stocks du Bon de Livraison <b>\"#{ data.labelBdl }\"</b> : "
          tabStock += "<table class='table table-bordered'><tr><th>Produit</th><th>Quantité Initiale</th><th>Quantité Restante</th></tr>#{ data.tabOrigin }</table>"
          $("#stockBdl").html(tabStock)
          
      )
    else
      $("#commande_client_id").val("")
      $("#stockBdl").html("")
  );
  
  # onChange sur le client : on clean le BdL
  $("#commande_client_id").change(() ->
    $("#commande_bdl_id").val("")
    $("#stockBdl").html("")
   );