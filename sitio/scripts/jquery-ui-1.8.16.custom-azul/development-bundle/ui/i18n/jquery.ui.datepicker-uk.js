/* Ukrainian (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Maxim Drogobitskiy (maxdao@gmail.com). */
jQuery(function($){
	$.datepicker.regional['uk'] = {
		closeText: 'D-D�D��_D,�,D,',
		prevText: '&#x3c;',
		nextText: '&#x3e;',
		currentText: 'D��OD_D3D_D'D��-',
		monthNames: ['D��-��D�D��O','D>�Z�,D,D1','D`D�_D�D�D�D��O','DsD��-�,D�D��O','D��_D�D�D�D��O','DD�_D�D�D��O',
		'D>D,D�D�D��O','D�D�_D�D�D��O','D'D�_D�_D�D��O','D-D_D��,D�D��O','D>D,�_�,D_D�D�D'','D"�_��D'D�D��O'],
		monthNamesShort: ['D��-��','D>�Z�,','D`D�_','DsD��-','D��_D�','DD�_',
		'D>D,D�','D�D�_','D'D�_','D-D_D�','D>D,�_','D"�_��'],
		dayNames: ['D�D�D'�-D��_','D�D_D�D�D'�-D�D_D�','D��-D��,D_�_D_D�','�_D�_D�D'D�','��D�,D�D�_','D��_T�_�,D�D,�+�_','�_��D�D_�,D�'],
		dayNamesShort: ['D�D�D'','D�D�D'','D��-D�','�_�_D'','�إ,D�','D��,D�','�_D�,'],
		dayNamesMin: ['D_D'','DYD�','D'�,','D��_','D�,','DY�,','D�D�'],
		weekHeader: 'D_D�',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['uk']);
});

