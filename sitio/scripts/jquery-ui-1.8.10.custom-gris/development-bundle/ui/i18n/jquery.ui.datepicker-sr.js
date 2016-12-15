���/* Serbian i18n for the jQuery UI date picker plugin. */
/* Written by Dejan Dimi��. */
jQuery(function($){
	$.datepicker.regional['sr'] = {
		closeText: 'D-D��,D�D_�_D,',
		prevText: '&#x3c;',
		nextText: '&#x3e;',
		currentText: 'D"D�D�D��_',
		monthNames: ['D^D�D���D��_','DD�D�_��D��_','DoD��_�,','D_D��_D,D�','DoD��~','D^��D�',
		'D^��D�','D_D�D3���_�,','D�D�D��,D�D�D�D��_','DzD��,D_D�D��_','D_D_D�D�D�D�D��_','D"D�+D�D�D�D��_'],
		monthNamesShort: ['D^D�D�','DD�D�','DoD��_','D_D��_','DoD��~','D^��D�',
		'D^��D�','D_D�D3','D�D�D�','DzD��,','D_D_D�','D"D�+'],
		dayNames: ['D_D�D'D�TD�','DYD_D�D�D'D�TD�D�','D��,D_�_D�D�','D��_D�D'D�','DD�,D��_�,D�D�','DYD�,D�D�','D���D�D_�,D�'],
		dayNamesShort: ['D_D�D'','DYD_D�','D��,D_','D��_D�','DD�,','DYD�,','D���D�'],
		dayNamesMin: ['D_D�','DYD_','D��,','D��_','DD�','DYD�','D���'],
		weekHeader: 'D�D�D'',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['sr']);
});


