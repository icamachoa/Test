/* Polish initialisation for the jQuery UI date picker plugin. */
/* Written by Jacek Wysocki (jacek.wysocki@gmail.com). */
jQuery(function($){
	$.datepicker.regional['pl'] = {
		closeText: 'Zamknij',
		prevText: '&#x3c;Poprzedni',
		nextText: 'Nast�Tpny&#x3e;',
		currentText: 'Dzi�>',
		monthNames: ['Stycze�,','Luty','Marzec','Kwiecie�,','Maj','Czerwiec',
		'Lipiec','Sierpie�,','Wrzesie�,','Pa��dziernik','Listopad','Grudzie�,'],
		monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
		'Lip','Sie','Wrz','Pa','Lis','Gru'],
		dayNames: ['Niedziela','Poniedzia�,ek','Wtorek','�sroda','Czwartek','Pi�.tek','Sobota'],
		dayNamesShort: ['Nie','Pn','Wt','�sr','Czw','Pt','So'],
		dayNamesMin: ['N','Pn','Wt','�sr','Cz','Pt','So'],
		weekHeader: 'Tydz',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['pl']);
});


