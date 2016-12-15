/* Lithuanian (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* @author Arturas Paleicikas <arturas@avalon.lt> */
jQuery(function($){
	$.datepicker.regional['lt'] = {
		closeText: 'U�_daryti',
		prevText: '&#x3c;Atgal',
		nextText: 'Pirmyn&#x3e;',
		currentText: '��iandien',
		monthNames: ['Sausis','Vasaris','Kovas','Balandis','Gegu�_�-','Bir�_elis',
		'Liepa','Rugpj��tis','Rugs�-jis','Spalis','Lapkritis','Gruodis'],
		monthNamesShort: ['Sau','Vas','Kov','Bal','Geg','Bir',
		'Lie','Rugp','Rugs','Spa','Lap','Gru'],
		dayNames: ['sekmadienis','pirmadienis','antradienis','tre�_iadienis','ketvirtadienis','penktadienis','��e��tadienis'],
		dayNamesShort: ['sek','pir','ant','tre','ket','pen','��e��'],
		dayNamesMin: ['Se','Pr','An','Tr','Ke','Pe','��e'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['lt']);
});

