/* Azerbaijani (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Jamil Najafov (necefov33@gmail.com). */
jQuery(function($) {
	$.datepicker.regional['az'] = {
		closeText: 'Ba�Yla',
		prevText: '&#x3c;Geri',
		nextText: '��r�Tli&#x3e;',
		currentText: 'BugA�n',
		monthNames: ['Yanvar','Fevral','Mart','Aprel','May','��yun',
		'��yul','Avqust','Sentyabr','Oktyabr','Noyabr','Dekabr'],
		monthNamesShort: ['Yan','Fev','Mar','Apr','May','��yun',
		'��yul','Avq','Sen','Okt','Noy','Dek'],
		dayNames: ['Bazar','Bazar ert�Tsi','AؐTr�Y�Tnb�T ax�Yam��','AؐTr�Y�Tnb�T','CA�m�T ax�Yam��','CA�m�T','�z�Tnb�T'],
		dayNamesShort: ['B','Be','A�a','A�','Ca','C','�z'],
		dayNamesMin: ['B','B','A�','D�','A�','C','�z'],
		weekHeader: 'Hf',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['az']);
});

