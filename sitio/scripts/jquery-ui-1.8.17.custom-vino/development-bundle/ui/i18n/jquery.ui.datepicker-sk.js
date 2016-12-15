/* Slovak initialisation for the jQuery UI date picker plugin. */
/* Written by Vojtech Rinik (vojto@hmm.sk). */
jQuery(function($){
	$.datepicker.regional['sk'] = {
		closeText: 'Zavrie��',
		prevText: '&#x3c;PredchA�dzajA�ci',
		nextText: 'NasledujA�ci&#x3e;',
		currentText: 'Dnes',
		monthNames: ['JanuA�r','FebruA�r','Marec','AprA-l','MA�j','JA�n',
		'JA�l','August','September','OktA3ber','November','December'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','MA�j','JA�n',
		'JA�l','Aug','Sep','Okt','Nov','Dec'],
		dayNames: ['Nede�_a','Pondelok','Utorok','Streda','��tvrtok','Piatok','Sobota'],
		dayNamesShort: ['Ned','Pon','Uto','Str','��tv','Pia','Sob'],
		dayNamesMin: ['Ne','Po','Ut','St','��t','Pia','So'],
		weekHeader: 'Ty',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['sk']);
});


