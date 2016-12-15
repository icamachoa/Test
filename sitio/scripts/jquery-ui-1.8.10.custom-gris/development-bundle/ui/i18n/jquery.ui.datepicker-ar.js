���/* Arabic Translation for jQuery UI date picker plugin. */
/* Khaled Alhourani -- me@khaledalhourani.com */
/* NOTE: monthNames are the original months names and they are the Arabic names, not the new months name U_O"O�OUSO� - USU+OUSO� and there isn't any Arabic roots for these months */
jQuery(function($){
	$.datepicker.regional['ar'] = {
		closeText: 'O�O�U,OU,',
		prevText: '&#x3c;OU,O3OO"U,',
		nextText: 'OU,O�OU,US&#x3e;',
		currentText: 'OU,USU^U.',
		monthNames: ['U�OU+U^U+ OU,O�OU+US', 'O'O"OO�', 'O�O�OO�', 'U+USO3OU+', 'O�O�OO�', 'O-O�USO�OU+',
		'O�U.U^O�', 'O�O"', 'O�USU,U^U,',	'O�O'O�USU+ OU,O�U^U,', 'O�O'O�USU+ OU,O�OU+US', 'U�OU+U^U+ OU,O�U^U,'],
		monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
		dayNames: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		dayNamesShort: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		dayNamesMin: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		weekHeader: 'O�O3O"U^O1',
		dateFormat: 'dd/mm/yy',
		firstDay: 6,
  		isRTL: true,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ar']);
});

