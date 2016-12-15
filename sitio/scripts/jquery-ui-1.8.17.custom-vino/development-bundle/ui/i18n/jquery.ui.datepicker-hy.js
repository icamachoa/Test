/* Armenian(UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Levon Zakaryan (levon.zakaryan@gmail.com)*/
jQuery(function($){
	$.datepicker.regional['hy'] = {
		closeText: 'O"O�O_O�O�',
		prevText: '&#x3c;O+O�O-.',
		nextText: 'O_O�O�.&#x3e;',
		currentText: 'O�O�O��.�_',
		monthNames: ['O_O,�,OO_O��_','O"O�O��_O_O��_','O,O��_O�','O�O��_O�O�','O,O�O�O�O�','O_O,�,OO�O�',
		'O_O,�,O�O�O�','OO�O,O�O�O,O�','O_O�O�O�O�O'O�O��_','O_O,O_O�O�O'O�O��_','O+O,O�O�O'O�O��_','O'O�O_O�O�O'O�O��_'],
		monthNamesShort: ['O_O,�,OO_','O"O�O��_','O,O��_O�','O�O��_','O,O�O�O�O�','O_O,�,OO�O�',
		'O_O,�,O�','OO�O�','O_O�O�','O_O,O_','O+O,O�','O'O�O_'],
		dayNames: ['O_O��_O�O_O�','O�O_O,�,O�O�O�OcO�','O��_O��,O�O�O�OcO�','O1O,�_O��,O�O�O�OcO�','O�O�OO�O�O�O�OcO�','O,�,�_O�O�Oc','O�O�O�O�Oc'],
		dayNamesShort: ['O_O��_','O��_O_','O��_�,','O1�_�,','O�OO�','O,�,�_O�','O�O�Oc'],
		dayNamesMin: ['O_O��_','O��_O_','O��_�,','O1�_�,','O�OO�','O,�,�_O�','O�O�Oc'],
		weekHeader: 'O�O�O_',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['hy']);
});

