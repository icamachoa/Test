���/* Thai initialisation for the jQuery UI date picker plugin. */
/* Written by pipo (pipo@sixhead.com). */
jQuery(function($){
	$.datepicker.regional['th'] = {
		closeText: '�,>�,'�,"',
		prevText: '&laquo;&nbsp;�,��1%�,-�,T',
		nextText: '�,-�,�,"�1,�,>&nbsp;&raquo;',
		currentText: '�,�,�,T�,T�,�1%',
		monthNames: ['�,��,_�,��,��,,�,�','�,_�,,�,��,��,��,z�,�,T�,~�1O','�,��,�,T�,��,,�,�','�1_�,��,c�,��,��,T','�,z�,�,c�,��,��,,�,�','�,��,'�,-�,,�,T�,��,��,T',
		'�,_�,��,_�,Z�,��,,�,�','�,��,'�,؅,��,��,,�,�','�,_�,�,T�,��,��,��,T','�,�,,�,��,��,,�,�','�,z�,�,"�,^�,'�,_�,��,��,T','�,~�,�,T�,�,��,,�,�'],
		monthNamesShort: ['�,�.�,,.','�,_.�,z.','�,��,�.�,,.','�1_�,�.�,�.','�,z.�,,.','�,��,'.�,�.',
		'�,_.�,,.','�,�.�,,.','�,_.�,�.','�,.�,,.','�,z.�,�.','�,~.�,,.'],
		dayNames: ['�,-�,��,-�,'�,�,��1O','�,^�,�,T�,-�,��1O','�,-�,�,؅,,�,��,�','�,z�,,�,~','�,z�,�,��,�,��,s�,"�,�','�,"�,,�,_�,��1O','�1_�,��,��,��1O'],
		dayNamesShort: ['�,-�,�.','�,^.','�,-.','�,z.','�,z�,.','�,".','�,�.'],
		dayNamesMin: ['�,-�,�.','�,^.','�,-.','�,z.','�,z�,.','�,".','�,�.'],
		weekHeader: 'Wk',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['th']);
});

