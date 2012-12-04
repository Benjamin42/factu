# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
  # Methode de mise a jour du filtre
  updateFilter = () -> 
    if $("#filter_month").val() isnt undefined && $("#filter_year").val() isnt undefined
      dateFilter = (if $("#filter_month").val().length is 2 then $("#filter_month").val() else "0" + $("#filter_month").val()) + "/" + $("#filter_year").val()
      oTable.fnFilter( dateFilter );
      hrefExcelButton = $("#excelButton").attr("href")
      if /dateFilter/.test(hrefExcelButton)
        hrefExcelButton = hrefExcelButton.replace /dateFilter=[0-9]{2}\/[0-9]{4}/, "dateFilter=#{ dateFilter }"
      else
        hrefExcelButton = "#{ hrefExcelButton }?dateFilter=#{ dateFilter }"
      $("#excelButton").attr("href", hrefExcelButton)

  now = new Date()
  $("#filter_month").val(now.getMonth() + 1)
  $("#filter_year").val(now.getFullYear())

  oTable = $('#fin_de_mois').dataTable(
    sDom: 'rt<"clear">'
    bPaginate: false
    "fnFooterCallback":  ( nFoot, aaData, iStart, iEnd, aiDisplay ) ->
      # Calculate the total market share for all browsers in this table (ie inc. outside
      # the pagination)
      iTotalMarket = 0;
      #for i in [0..aaData.length]
      #  iTotalMarket += aaData[i][4] * 1;
      
      # Calculate the market share for browsers on this page 
      iPageMarket = 0;
      #for i in [iStart..iEnd]
      #  iPageMarket += aaData[ aiDisplay[i] ][4] * 1;
      
      # Modify the footer row to match what we want 
      #nCells = nFoot.getElementsByTagName('th');
      #nCells[1].innerHTML = parseInt(iPageMarket * 100)/100 +
      #  '% ('+ parseInt(iTotalMarket * 100)/100 +'% total)';
    
  )
  updateFilter()
  
  # Mise a jour du filtre quand changement de date dans Select
  $("#filter_month").change(updateFilter)
  $("#filter_year").change(updateFilter)

  