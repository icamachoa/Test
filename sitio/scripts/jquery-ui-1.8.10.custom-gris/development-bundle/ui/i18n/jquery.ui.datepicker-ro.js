���/* Romanian initialisation for the jQuery UI date picker plugin.
 *
 * Written by Edmond L. (ll_edmond@walla.com)
 * and Ionut G. Stan (ionut.g.stan@gmail.com)
 */
jQuery(function($){
	$.datepicker.regional['ro'] = {
		closeText: 'AZnchide',
		prevText: '&laquo; Luna precedent��',
		nextText: 'Luna urm��toare &raquo;',
		currentText: 'Azi',
		monthNames: ['Ianuarie','Februarie','Martie','Aprilie','Mai','Iunie',
		'Iulie','August','Septembrie','Octombrie','Noiembrie','Decembrie'],
		monthNamesShort: ['Ian', 'Feb', 'Mar', 'Apr', 'Mai', 'Iun',
		'Iul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		dayNames: ['Duminic��', 'Luni', 'Mar��i', 'Miercuri', 'Joi', 'Vineri', 'SA�mb��t��'],
		dayNamesShort: ['Dum', 'Lun', 'Mar', 'Mie', 'Joi', 'Vin', 'SA�m'],
		dayNamesMin: ['Du','Lu','Ma','Mi','Jo','Vi','SA�'],
		weekHeader: 'S��pt',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ro']);
});


