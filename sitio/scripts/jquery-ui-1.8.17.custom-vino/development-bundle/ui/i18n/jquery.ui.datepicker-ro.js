/* Romanian initialisation for the jQuery UI date picker plugin.
 *
 * Written by Edmond L. (ll_edmond@walla.com)
 * and Ionut G. Stan (ionut.g.stan@gmail.com)
 */
jQuery(function($){
	$.datepicker.regional['ro'] = {
		closeText: 'AZnchide',
		prevText: '&laquo; Luna precedent次',
		nextText: 'Luna urm次toare &raquo;',
		currentText: 'Azi',
		monthNames: ['Ianuarie','Februarie','Martie','Aprilie','Mai','Iunie',
		'Iulie','August','Septembrie','Octombrie','Noiembrie','Decembrie'],
		monthNamesShort: ['Ian', 'Feb', 'Mar', 'Apr', 'Mai', 'Iun',
		'Iul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		dayNames: ['Duminic次', 'Luni', 'Mar除i', 'Miercuri', 'Joi', 'Vineri', 'SA嬶b次t次'],
		dayNamesShort: ['Dum', 'Lun', 'Mar', 'Mie', 'Joi', 'Vin', 'SA嬶'],
		dayNamesMin: ['Du','Lu','Ma','Mi','Jo','Vi','SA�'],
		weekHeader: 'S次pt',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ro']);
});


