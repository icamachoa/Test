/* Kazakh (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Dmitriy Karasyov (dmitriy.karasyov@gmail.com). */
jQuery(function($){
	$.datepicker.regional['kk'] = {
		closeText: 'D-D�D�',
		prevText: '&#x3c;D_D�D'�<O�O"�<',
		nextText: 'DsD�D�D�_�-&#x3e;',
		currentText: 'D`O_D3�-D�',
		monthNames: ['OsD�O��,D��_','D_O>D�D�D�','D_D����_�<D�','D�OT���-�_','DoD�D��<�_','DoD����_�<D�',
		'D"�-D�D'D�','D�D�D��<D�','Os�<�_D�O_D1D�D�','OsD�D�D�D�','OsD��_D��^D�','D-D�D��,D_O>�_D�D�'],
		monthNamesShort: ['OsD�O�','D_O>D�','D_D���','D�OT��','DoD�D�','DoD���',
		'D"�-D�','D�D�D�','Os�<�_','OsD�D�','OsD��_','D-D�D�'],
		dayNames: ['D-D�D��_D�D�D�-','D"O_D1�_D�D�D�-','D�D�D1�_D�D�D�-','D�OT�_�_D�D�D�-','D`D�D1�_D�D�D�-','D-O�D�D�','D�D�D�D�-'],
		dayNamesShort: ['DD��_','D'�_D�','�_�_D�','�_�_�_','D�_D�','DD�D�','�_D�D�'],
		dayNamesMin: ['D-D�','D"�_','D��_','D��_','D`�_','D-D�','D�D�'],
		weekHeader: 'D_D�',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['kk']);
});


