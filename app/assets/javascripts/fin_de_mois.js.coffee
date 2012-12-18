# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
  # Methode de mise a jour du filtre
  updateFilter = () -> 
    month = $("#filter_month").val()
    year = $("#filter_year").val()  
    if month isnt undefined && year isnt undefined
      dateFilter = ""

      if month isnt "" && year isnt ""      
        dateFilter = (if month.length is 2 then month else "0" + month) + "/" + year
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
    fnFooterCallback: (nRow, aaData, iStart, iEnd, aiDisplay) ->
      nCells = nRow.getElementsByTagName('th')
      for col in [3..100]
        if nCells[col] is undefined
          break
        sum = 0       
        if iEnd - iStart > 0
          for i in [iStart..(iEnd-1)]
            sum += parseInt(aaData[ aiDisplay[i] ][col])
        
        nCells[col].innerHTML = sum
  )
  updateFilter()
  
  # Mise a jour du filtre quand changement de date dans Select
  $("#filter_month").change(updateFilter)
  $("#filter_year").change(updateFilter)

  