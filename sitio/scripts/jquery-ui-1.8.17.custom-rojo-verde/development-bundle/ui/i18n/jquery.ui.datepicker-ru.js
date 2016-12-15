/* Russian (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Andrew Stromnov (stromnov@gmail.com). */
jQuery(function($){
	$.datepicker.regional['ru'] = {
		closeText: 'D-D�D��_�<�,�O',
		prevText: '&#x3c;DY�_D�D'',
		nextText: 'D�D�D�D'&#x3e;',
		currentText: 'D�D�D3D_D'D��_',
		monthNames: ['D_D�D�D��_�O','DD�D��_D�D��O','DoD��_�,','D_D��_D�D��O','DoD�D1','D~�ZD��O',
		'D~�ZD��O','D_D�D3���_�,','D�D�D��,�_D�_�O','DzD��,�_D�_�O','D_D_�_D�_�O','D"D�D�D�D�_�O'],
		monthNamesShort: ['D_D�D�','DD�D�','DoD��_','D_D��_','DoD�D1','D~�ZD�',
		'D~�ZD�','D_D�D3','D�D�D�','DzD��,','D_D_�_','D"D�D�'],
		dayNames: ['D�D_�_D��_D�_D�D��OD�','D�D_D�D�D'D�D��OD�D,D�','D��,D_�_D�D,D�','�_�_D�D'D�','��D�,D�D�_D3','D��_�,D�D,�+D�','�_��D�D�D_�,D�'],
		dayNamesShort: ['D��_D�','D�D�D'','D��,�_','�_�_D'','�إ,D�','D��,D�','�_D�,'],
		dayNamesMin: ['D'�_','DYD�','D'�,','D��_','D�,','DY�,','D�D�'],
		weekHeader: 'D_D�D'',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ru']);
});

