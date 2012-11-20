function show(id) {
	$('#' + id).show();
}

function hide(id) {
	$('#' + id).hide();
}

function inverse(id) {
	var elem = $('#' + id);
	if (elem.is(':hidden')) {
		show(id);
	} else {
		hide(id);
	}
}
