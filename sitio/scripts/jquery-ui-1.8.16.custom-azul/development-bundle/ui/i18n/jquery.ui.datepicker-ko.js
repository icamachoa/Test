/* Korean initialisation for the jQuery calendar extension. */
/* Written by DaeKwon Kang (ncrash.dk@gmail.com). */
jQuery(function($){
	$.datepicker.regional['ko'] = {
		closeText: '�<��,�',
		prevText: '�_'��,�<�',
		nextText: '�<�_O�<�',
		currentText: '�~�S~',
		monthNames: ['1�>"(JAN)','2�>"(FEB)','3�>"(MAR)','4�>"(APR)','5�>"(MAY)','6�>"(JUN)',
		'7�>"(JUL)','8�>"(AUG)','9�>"(SEP)','10�>"(OCT)','11�>"(NOV)','12�>"(DEC)'],
		monthNamesShort: ['1�>"(JAN)','2�>"(FEB)','3�>"(MAR)','4�>"(APR)','5�>"(MAY)','6�>"(JUN)',
		'7�>"(JUL)','8�>"(AUG)','9�>"(SEP)','10�>"(OCT)','11�>"(NOV)','12�>"(DEC)'],
		dayNames: ['�_�','�>"','�T"','�^~','��c','�,^','�+�'],
		dayNamesShort: ['�_�','�>"','�T"','�^~','��c','�,^','�+�'],
		dayNamesMin: ['�_�','�>"','�T"','�^~','��c','�,^','�+�'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: '�.,'};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
});

