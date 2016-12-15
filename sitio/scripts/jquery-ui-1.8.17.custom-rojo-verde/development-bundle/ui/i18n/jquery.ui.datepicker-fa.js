/* Persian (Farsi) Translation for the jQuery UI date picker plugin. */
/* Javad Mowlanezhad -- jmowla@gmail.com */
/* Jalali calendar should supported soon! (Its implemented but I have to test it) */
jQuery(function($) {
	$.datepicker.regional['fa'] = {
		closeText: 'O"O3O�U+',
		prevText: '&#x3c;U,O"U,US',
		nextText: 'O"O1O_US&#x3e;',
		currentText: 'OU.O�U^O�',
		monthNames: ['U_O�U^O�O_USU+','OO�O_USO"U�O'O�','OrO�O_OO_','O�USO�','U.O�O_OO_','O'U�O�USU^O�',
		'U.U�O�','O�O"OU+','O�O�O�','O_US','O"U�U.U+','OO3U_U+O_'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: ['USUcO'U+O"U�','O_U^O'U+O"U�','O3U؃_OO'U+O"U�','U+U�OO�O'U+O"U�','U_U+O�O'U+O"U�','O�U.O1U�','O'U+O"U�'],
		dayNamesShort: ['US','O_','O3','U+','U_','O�', 'O''],
		dayNamesMin: ['US','O_','O3','U+','U_','O�', 'O''],
		weekHeader: 'U�U_',
		dateFormat: 'yy/mm/dd',
		firstDay: 6,
		isRTL: true,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['fa']);
});

