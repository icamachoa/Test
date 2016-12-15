/* Algerian Arabic Translation for jQuery UI date picker plugin. (can be used for Tunisia)*/
/* Mohamed Cherif BOUCHELAGHEM -- cherifbouchelaghem@yahoo.fr */

jQuery(function($){
	$.datepicker.regional['ar-DZ'] = {
		closeText: 'O�O�U,OU,',
		prevText: '&#x3c;OU,O3OO"U,',
		nextText: 'OU,O�OU,US&#x3e;',
		currentText: 'OU,USU^U.',
		monthNames: ['O�OU+U_US', 'U_USU_O�US', 'U.OO�O3', 'O�U_O�USU,', 'U.OUS', 'O�U^OU+',
		'O�U^USU,USOc', 'O�U^O�', 'O3O"O�U.O"O�','O�U�O�U^O"O�', 'U+U^U_U.O"O�', 'O_USO3U.O"O�'],
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
	$.datepicker.setDefaults($.datepicker.regional['ar-DZ']);
});


