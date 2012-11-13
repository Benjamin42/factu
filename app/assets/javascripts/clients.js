$(document).ready(function() {
    $('#clients').dataTable(
    	sAjaxSource = $('#clients').data('index'),
    	bJQueryUI = true,
	    bProcessing = true,
	    bServerSide = true
	);
    
    
} );