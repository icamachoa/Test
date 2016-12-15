���/* Greek (el) initialisation for the jQuery UI date picker plugin. */
/* Written by Alex Cicovic (http://www.alexcicovic.com) */
jQuery(function($){
	$.datepicker.regional['el'] = {
		closeText: 'IsI�I�I_I�I1I�I�',
		prevText: 'I�I_I�I�I3I�I_I�I�I�I�I,',
		nextText: 'II_IOI�I�I�I�I,',
		currentText: 'II_I-I�I%I� IoIrI�I�I,',
		monthNames: ['ITI�I�I�I.I�I_I1I�I,','I�I�I�I_I�I.I�I_I1I�I,','IoI�I_I,I1I�I,','I`I_I_I_I�I1I�I,','IoI�I1I�I,','ITI�I_I�I1I�I,',
		'ITI�I_I�I1I�I,','I`I_I3I�I.I�I,I�I,','I�I�I_I,I-I�I�I_I1I�I,','IYI�I,IZI�I_I1I�I,','I_I�I-I�I�I_I1I�I,','I"I�I�I-I�I�I_I1I�I,'],
		monthNamesShort: ['ITI�I�','I�I�I�','IoI�I_','I`I_I_','IoI�I1','ITI�I.I�',
		'ITI�I.I�','I`I.I3','I�I�I_','IYI�I,','I_I�I�','I"I�I�'],
		dayNames: ['IsI.I_I1I�I�Ir','I"I�I.I,I-I_I�','II_I_I,I�','II�I,I�I_I,I�','I�I-I�I_I,I�','I�I�I_I�I�I�I�I.Ir','I�I�I�I�I�I,I�'],
		dayNamesShort: ['IsI.I_','I"I�I.','II_I1','II�I,','I�I�I�','I�I�I_','I�I�I�'],
		dayNamesMin: ['IsI.','I"I�','II_','II�','I�I�','I�I�','I�I�'],
		weekHeader: 'II�I'',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['el']);
});

