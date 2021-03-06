¯š/* Malayalam (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Saji Nediyanchath (saji89@gmail.com). */
jQuery(function($){
	$.datepicker.regional['ml'] = {
		closeText: '''ø'š',
		prevText: ''ræ_'"æ_'"'æ_'æ+',  
		nextText: ''.'Yæ_'æ_''æ_ ',
		currentText: ''Ø'"æ_'"æ_',
		monthNames: [''o'"æ_'æ'ø'š',''®æ+'ªæ_'øæ_'æ'ø'š',''r'_'øæ___'sæ_'sæ_',''_'Šæ_'ø'š'ýæ___',''ræØ'_æ_',''oæ,'æ___',
		''oæ,'ýæ^',''+'-',æ_'ñæ_'ñæ_','',æ+'Šæ_'ñæ_'ñ','ª'øæ___',''''æ_'Yæ<'ª'øæ___',''"'æ','ª'øæ___',''­'š',','ª'øæ___'],
		monthNamesShort: [''o'"æ_', ''®æ+'ªæ_', ''r'_'øæ___', ''_'Šæ_'ø'š', ''ræØ'_æ_', ''oæ,'æ___',
		''oæ,'ý'_', ''+'-', '',æ+'Šæ_', ''''æ_'Yæ<', ''"'æ',', ''­'š','],
		dayNames: [''z'_'_'øæ___', '''š'Tæ_''3æ___', ''sæS'ææ_'æ', ''ªæ_''"æ___', ''ææ_'_'_''',', ''ææ+'3æ_'3'š', '''"'š'],
		dayNamesShort: [''z'_'_', '''š'Tæ_'', ''sæS'ææ_'æ', ''ªæ_'', ''ææ_'_'_''',', ''ææ+'3æ_'3'š', '''"'š'],
		dayNamesMin: [''z'_','''š',''sæS',''ªæ_',''ææ_'_'_',''ææ+','''],
		weekHeader: ''+',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ml']);
});


