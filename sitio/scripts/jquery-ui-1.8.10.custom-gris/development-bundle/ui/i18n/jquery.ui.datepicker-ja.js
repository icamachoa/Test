¯¨/* Japanese initialisation for the jQuery UI date picker plugin. */
/* Written by Kentaro SATO (kentaro@ranvis.com). */
jQuery(function($){
	$.datepicker.regional['ja'] = {
		closeText: '-%a_~a,<',
		prevText: '&#x3c;%_',
		nextText: 'ª­&#x3e;',
		currentText: '¯S-',
		monthNames: ['1o^','2o^','3o^','4o^','5o^','6o^',
		'7o^','8o^','9o^','10o^','11o^','12o^'],
		monthNamesShort: ['1o^','2o^','3o^','4o^','5o^','6o^',
		'7o^','8o^','9o^','10o^','11o^','12o^'],
		dayNames: ['->o-','o^>o-','_®>o-','ø'>o-','o">o-','Ø`>o-','oY>o-'],
		dayNamesShort: ['-','o^','_®','ø'','o"','Ø`','oY'],
		dayNamesMin: ['-','o^','_®','ø'','o"','Ø`','oY'],
		weekHeader: '_ñ',
		dateFormat: 'yy/mm/dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '1''};
	$.datepicker.setDefaults($.datepicker.regional['ja']);
});

