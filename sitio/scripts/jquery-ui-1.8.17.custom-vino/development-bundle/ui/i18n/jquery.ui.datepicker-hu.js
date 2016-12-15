/* Hungarian initialisation for the jQuery UI date picker plugin. */
/* Written by Istvan Karaszi (jquery@spam.raszi.hu). */
jQuery(function($){
	$.datepicker.regional['hu'] = {
		closeText: 'bezA�r',
		prevText: 'vissza',
		nextText: 'el�`re',
		currentText: 'ma',
		monthNames: ['JanuA�r', 'FebruA�r', 'MA�rcius', 'A_prilis', 'MA�jus', 'JA�nius',
		'JA�lius', 'Augusztus', 'Szeptember', 'OktA3ber', 'November', 'December'],
		monthNamesShort: ['Jan', 'Feb', 'MA�r', 'A_pr', 'MA�j', 'JA�n',
		'JA�l', 'Aug', 'Szep', 'Okt', 'Nov', 'Dec'],
		dayNames: ['VasA�rnap', 'HActf�`', 'Kedd', 'Szerda', 'CsA�tArtAk', 'PAcntek', 'Szombat'],
		dayNamesShort: ['Vas', 'HAct', 'Ked', 'Sze', 'CsA�', 'PAcn', 'Szo'],
		dayNamesMin: ['V', 'H', 'K', 'Sze', 'Cs', 'P', 'Szo'],
		weekHeader: 'HAct',
		dateFormat: 'yy.mm.dd.',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['hu']);
});


