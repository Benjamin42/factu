# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
  $('#fin_de_mois').dataTable(
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
  