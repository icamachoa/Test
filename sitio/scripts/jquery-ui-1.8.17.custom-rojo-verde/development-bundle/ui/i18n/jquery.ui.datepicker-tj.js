/* Tajiki (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Abdurahmon Saidov (saidovab@gmail.com). */
jQuery(function($){
	$.datepicker.regional['tj'] = {
		closeText: 'D~D'D_D�D�',
		prevText: '&#x3c;OsD��,D_',
		nextText: 'DYD�^&#x3e;',
		currentText: 'D~D��_O_D�',
		monthNames: ['D_D�D�D��_','DD�D��_D�D�','DoD��_�,','D_D��_D�D�','DoD�D1','D~�ZD�',
		'D~�ZD�','D_D�D3���_�,','D�D�D��,�_D�_','DzD��,�_D�_','D_D_�_D�_','D"D�D�D�D�_'],
		monthNamesShort: ['D_D�D�','DD�D�','DoD��_','D_D��_','DoD�D1','D~�ZD�',
		'D~�ZD�','D_D�D3','D�D�D�','DzD��,','D_D_�_','D"D�D�'],
		dayNames: ['�_D��^D�D�D�D�','D'���^D�D�D�D�','�_D�^D�D�D�D�','��D_�_�^D�D�D�D�','D�D�D�O��^D�D�D�D�','O���D��SD�','�^D�D�D�D�'],
		dayNamesShort: ['�_D��^','D'���^','�_D�^','��D_�_','D�D�D�','O���D�','�^D�D�'],
		dayNamesMin: ['D_D�','D"�^','D��^','D�^','DY�^','OD�','D"D�'],
		weekHeader: 'D��,',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['tj']);
});

