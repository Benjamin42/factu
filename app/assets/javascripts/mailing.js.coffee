# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#clients-mailing').dataTable(
    sPaginationType: "full_numbers"
    aaSorting: [[ 1, "asc" ]]
    aoColumns: [                                                                 
       { "bSortable": true}                                                   
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
       { "bSortable": true}
      ]    
  )
  
  editor = $('.wysihtml5').each((i, elem) ->
      $(elem).wysihtml5({
          "font-styles": true, # Font styling, e.g. h1, h2, etc. Default true
          "emphasis": true, # Italics, bold, etc. Default true
          "lists": true, # (Un)ordered lists, e.g. Bullets, Numbers. Default true
          "html": false, # Button which allows you to edit the generated HTML. Default false
          "link": true, # Button to insert a link. Default true
          "image": true, # Button to insert an image. Default true,
          "color": true # Button to change color of font  
      });
  );  
  
  # Bouton BROUILLON
  $("#btn-brouillon").click ->
    params =
      message : $('#message-textarea').val()
      
    $.getJSON("/mailing/saveBrouillon", params, (data) ->
        if data.success is "true"
          messToPrint = "<div class='alert alert-success'>Brouillon sauvegardé</div>"
        else
          messToPrint = "<div class='alert alert-error'>Erreur lors de la sauvegarde du Brouillon</div>"
          
        $("#messToPrint").html(messToPrint)
    )
    
  # Bouton SAUVEGARDE ENVOI
  $("#btn-envoi").click ->
    params =
      message : $('#message-textarea').val()
      
    $.getJSON("/mailing/saveEnvoi", params, (data) ->
        if data.success is "true"
          messToPrint = "<div class='alert alert-success'>Message envoyé sauvegardé</div>"
        else
          messToPrint = "<div class='alert alert-error'>Erreur lors de la sauvegarde du message envoyé</div>"
          
        $("#messToPrint").html(messToPrint)
    
        # On vide le textarea
        editorInstance = editor.data('wysihtml5').editor;
        editorInstance.setValue('', true);
    )
    
  addPrintedClient = (divs, client) ->
    divs = "#{ divs }<div class='to_be_printed client'>#{ client }<img src='/assets/logo.png'></div>"
    return divs
    
  # Bouton IMPRIMER 
  $("#btn-print").click ->
    divs = ""
    divs = addPrintedClient(divs, client) for client in ["moi", "toi", "lui"]
    $("#to_be_printed").html(divs)
    window.print()
    