���/* Vietnamese initialisation for the jQuery UI date picker plugin. */
/* Translated by Le Thanh Huy (lthanhhuy@cit.ctu.edu.vn). */
jQuery(function($){
	$.datepicker.regional['vi'] = {
		closeText: '�_A3ng',
		prevText: '&#x3c;Tr����>c',
		nextText: 'Ti���p&#x3e;',
		currentText: 'HA'm nay',
		monthNames: ['ThA�ng M��Tt', 'ThA�ng Hai', 'ThA�ng Ba', 'ThA�ng T��', 'ThA�ng N��m', 'ThA�ng SA�u',
		'ThA�ng B���y', 'ThA�ng TA�m', 'ThA�ng ChA-n', 'ThA�ng M����_i', 'ThA�ng M����_i M��Tt', 'ThA�ng M����_i Hai'],
		monthNamesShort: ['ThA�ng 1', 'ThA�ng 2', 'ThA�ng 3', 'ThA�ng 4', 'ThA�ng 5', 'ThA�ng 6',
		'ThA�ng 7', 'ThA�ng 8', 'ThA�ng 9', 'ThA�ng 10', 'ThA�ng 11', 'ThA�ng 12'],
		dayNames: ['Ch�� Nh��-t', 'Th��c Hai', 'Th��c Ba', 'Th��c T��', 'Th��c N��m', 'Th��c SA�u', 'Th��c B���y'],
		dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
		dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
		weekHeader: 'Tu',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['vi']);
});


