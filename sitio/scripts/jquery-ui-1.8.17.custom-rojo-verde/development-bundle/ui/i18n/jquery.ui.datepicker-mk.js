/* Macedonian i18n for the jQuery UI date picker plugin. */
/* Written by Stojce Slavkovski. */
jQuery(function($){
	$.datepicker.regional['mk'] = {
		closeText: 'D-D��,D�D_�_D,',
		prevText: '&#x3C;',
		nextText: '&#x3E;',
		currentText: 'D"D�D�D�_',
		monthNames: ['D^D�D���D��_D,','DD�D�_��D��_D,','DoD��_�,','D_D��_D,D�','DoD��~','D^��D�D,',
		'D^��D�D,','D_D�D3���_�,','D�D�D��,D�D�D��_D,','DzD��,D_D�D��_D,','D_D_D�D�D��_D,','D"D�D�D�D�D��_D,'],
		monthNamesShort: ['D^D�D�','DD�D�','DoD��_','D_D��_','DoD��~','D^��D�',
		'D^��D�','D_D�D3','D�D�D�','DzD��,','D_D_D�','D"D�D�'],
		dayNames: ['D_D�D'D�D�D�','DYD_D�D�D'D�D�D�D,D�','D'�,D_�_D�D,D�','D��_D�D'D�','DD�,D��_�,D_D�','DYD�,D_D�','D�D�D�D_�,D�'],
		dayNamesShort: ['D_D�D'','DYD_D�','D'�,D_','D��_D�','DD�,','DYD�,','D�D�D�'],
		dayNamesMin: ['D_D�','DYD_','D'�,','D��_','DD�','DYD�','D�D�'],
		weekHeader: 'D�D�D'',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['mk']);
});


