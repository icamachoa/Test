���/* Afrikaans initialisation for the jQuery UI date picker plugin. */
/* Written by Renier Pretorius. */
jQuery(function($){
	$.datepicker.regional['af'] = {
		closeText: 'Selekteer',
		prevText: 'Vorige',
		nextText: 'Volgende',
		currentText: 'Vandag',
		monthNames: ['Januarie','Februarie','Maart','April','Mei','Junie',
		'Julie','Augustus','September','Oktober','November','Desember'],
		monthNamesShort: ['Jan', 'Feb', 'Mrt', 'Apr', 'Mei', 'Jun',
		'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Des'],
		dayNames: ['Sondag', 'Maandag', 'Dinsdag', 'Woensdag', 'Donderdag', 'Vrydag', 'Saterdag'],
		dayNamesShort: ['Son', 'Maa', 'Din', 'Woe', 'Don', 'Vry', 'Sat'],
		dayNamesMin: ['So','Ma','Di','Wo','Do','Vr','Sa'],
		weekHeader: 'Wk',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['af']);
});
/* Algerian Arabic Translation for jQuery UI date picker plugin. (can be used for Tunisia)*/
/* Mohamed Cherif BOUCHELAGHEM -- cherifbouchelaghem@yahoo.fr */

jQuery(function($){
	$.datepicker.regional['ar-DZ'] = {
		closeText: 'O�O�U,OU,',
		prevText: '&#x3c;OU,O3OO"U,',
		nextText: 'OU,O�OU,US&#x3e;',
		currentText: 'OU,USU^U.',
		monthNames: ['O�OU+U_US', 'U_USU_O�US', 'U.OO�O3', 'O�U_O�USU,', 'U.OUS', 'O�U^OU+',
		'O�U^USU,USOc', 'O�U^O�', 'O3O"O�U.O"O�','O�U�O�U^O"O�', 'U+U^U_U.O"O�', 'O_USO3U.O"O�'],
		monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
		dayNames: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		dayNamesShort: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		dayNamesMin: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		weekHeader: 'O�O3O"U^O1',
		dateFormat: 'dd/mm/yy',
		firstDay: 6,
  		isRTL: true,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ar-DZ']);
});
���/* Arabic Translation for jQuery UI date picker plugin. */
/* Khaled Alhourani -- me@khaledalhourani.com */
/* NOTE: monthNames are the original months names and they are the Arabic names, not the new months name U_O"O�OUSO� - USU+OUSO� and there isn't any Arabic roots for these months */
jQuery(function($){
	$.datepicker.regional['ar'] = {
		closeText: 'O�O�U,OU,',
		prevText: '&#x3c;OU,O3OO"U,',
		nextText: 'OU,O�OU,US&#x3e;',
		currentText: 'OU,USU^U.',
		monthNames: ['U�OU+U^U+ OU,O�OU+US', 'O'O"OO�', 'O�O�OO�', 'U+USO3OU+', 'O�O�OO�', 'O-O�USO�OU+',
		'O�U.U^O�', 'O�O"', 'O�USU,U^U,',	'O�O'O�USU+ OU,O�U^U,', 'O�O'O�USU+ OU,O�OU+US', 'U�OU+U^U+ OU,O�U^U,'],
		monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
		dayNames: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		dayNamesShort: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		dayNamesMin: ['OU,O�O-O_', 'OU,OO�U+USU+', 'OU,O�U,OO�OO�', 'OU,O�O�O"O1OO�', 'OU,OrU.USO3', 'OU,O�U.O1Oc', 'OU,O3O"O�'],
		weekHeader: 'O�O3O"U^O1',
		dateFormat: 'dd/mm/yy',
		firstDay: 6,
  		isRTL: true,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ar']);
});���/* Azerbaijani (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Jamil Najafov (necefov33@gmail.com). */
jQuery(function($) {
	$.datepicker.regional['az'] = {
		closeText: 'Ba�Yla',
		prevText: '&#x3c;Geri',
		nextText: '��r�Tli&#x3e;',
		currentText: 'BugA�n',
		monthNames: ['Yanvar','Fevral','Mart','Aprel','May','��yun',
		'��yul','Avqust','Sentyabr','Oktyabr','Noyabr','Dekabr'],
		monthNamesShort: ['Yan','Fev','Mar','Apr','May','��yun',
		'��yul','Avq','Sen','Okt','Noy','Dek'],
		dayNames: ['Bazar','Bazar ert�Tsi','AؐTr�Y�Tnb�T ax�Yam��','AؐTr�Y�Tnb�T','CA�m�T ax�Yam��','CA�m�T','�z�Tnb�T'],
		dayNamesShort: ['B','Be','A�a','A�','Ca','C','�z'],
		dayNamesMin: ['B','B','A�','D�','A�','C','�z'],
		weekHeader: 'Hf',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['az']);
});���/* Bulgarian initialisation for the jQuery UI date picker plugin. */
/* Written by Stoyan Kyosev (http://svest.org). */
jQuery(function($){
    $.datepicker.regional['bg'] = {
        closeText: 'D�D��,D�D_�_D,',
        prevText: '&#x3c;D�D�D�D�D'',
        nextText: 'D�D�D��_D�D'&#x3e;',
		nextBigText: '&#x3e;&#x3e;',
        currentText: 'D'D�D�_',
        monthNames: ['D_D���D��_D,','DD�D��_��D��_D,','DoD��_�,','D_D��_D,D�','DoD�D1','DrD�D,',
        'DrD�D,','D_D�D3���_�,','D�D�D��,D�D�D��_D,','DzD��,D_D�D��_D,','D_D_D�D�D��_D,','D"D�D�D�D�D��_D,'],
        monthNamesShort: ['D_D���','DD�D�','DoD��_','D_D��_','DoD�D1','DrD�D,',
        'DrD�D,','D_D�D3','D�D�D�','DzD��,','D_D_D�','D"D�D�'],
        dayNames: ['D_D�D'D�D��_','DYD_D�D�D'D�D�D�D,D�','D'�,D_�_D�D,D�','D��_�_D'D�','DD�,D��S�_�,�SD�','DYD�,�SD�','D��SD�D_�,D�'],
        dayNamesShort: ['D_D�D'','DYD_D�','D'�,D_','D��_�_','DD�,','DYD�,','D��SD�'],
        dayNamesMin: ['D_D�','DYD_','D'�,','D��_','DD�','DYD�','D��S'],
		weekHeader: 'Wk',
        dateFormat: 'dd.mm.yy',
		firstDay: 1,
        isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['bg']);
});
���/* Bosnian i18n for the jQuery UI date picker plugin. */
/* Written by Kenan Konjo. */
jQuery(function($){
	$.datepicker.regional['bs'] = {
		closeText: 'Zatvori', 
		prevText: '&#x3c;', 
		nextText: '&#x3e;', 
		currentText: 'Danas', 
		monthNames: ['Januar','Februar','Mart','April','Maj','Juni',
		'Juli','August','Septembar','Oktobar','Novembar','Decembar'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Maj','Jun',
		'Jul','Aug','Sep','Okt','Nov','Dec'],
		dayNames: ['Nedelja','Ponedeljak','Utorak','Srijeda','�Oetvrtak','Petak','Subota'],
		dayNamesShort: ['Ned','Pon','Uto','Sri','�Oet','Pet','Sub'],
		dayNamesMin: ['Ne','Po','Ut','Sr','�Oe','Pe','Su'],
		weekHeader: 'Wk',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['bs']);
});/* InicialitzaciA3 en catalA� per a l'extenciA3 'calendar' per jQuery. */
/* Writers: (joan.leon@gmail.com). */
jQuery(function($){
	$.datepicker.regional['ca'] = {
		closeText: 'Tancar',
		prevText: '&#x3c;Ant',
		nextText: 'Seg&#x3e;',
		currentText: 'Avui',
		monthNames: ['Gener','Febrer','Mar&ccedil;','Abril','Maig','Juny',
		'Juliol','Agost','Setembre','Octubre','Novembre','Desembre'],
		monthNamesShort: ['Gen','Feb','Mar','Abr','Mai','Jun',
		'Jul','Ago','Set','Oct','Nov','Des'],
		dayNames: ['Diumenge','Dilluns','Dimarts','Dimecres','Dijous','Divendres','Dissabte'],
		dayNamesShort: ['Dug','Dln','Dmt','Dmc','Djs','Dvn','Dsb'],
		dayNamesMin: ['Dg','Dl','Dt','Dc','Dj','Dv','Ds'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ca']);
});���/* Czech initialisation for the jQuery UI date picker plugin. */
/* Written by Tomas Muller (tomas@tomas-muller.net). */
jQuery(function($){
	$.datepicker.regional['cs'] = {
		closeText: 'Zav�TA-t',
		prevText: '&#x3c;D�TA-ve',
		nextText: 'Pozd�>ji&#x3e;',
		currentText: 'NynA-',
		monthNames: ['leden','A�nor','b�Tezen','duben','kv�>ten','�_erven',
        '�_ervenec','srpen','zA��TA-','�TA-jen','listopad','prosinec'],
		monthNamesShort: ['led','A�no','b�Te','dub','kv�>','�_er',
		'�_vc','srp','zA��T','�TA-j','lis','pro'],
		dayNames: ['ned�>le', 'pond�>lA-', 'A�terA�', 'st�Teda', '�_tvrtek', 'pA�tek', 'sobota'],
		dayNamesShort: ['ne', 'po', 'A�t', 'st', '�_t', 'pA�', 'so'],
		dayNamesMin: ['ne','po','A�t','st','�_t','pA�','so'],
		weekHeader: 'TA�d',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['cs']);
});
���/* Danish initialisation for the jQuery UI date picker plugin. */
/* Written by Jan Christensen ( deletestuff@gmail.com). */
jQuery(function($){
    $.datepicker.regional['da'] = {
		closeText: 'Luk',
        prevText: '&#x3c;Forrige',
		nextText: 'NA�ste&#x3e;',
		currentText: 'Idag',
        monthNames: ['Januar','Februar','Marts','April','Maj','Juni',
        'Juli','August','September','Oktober','November','December'],
        monthNamesShort: ['Jan','Feb','Mar','Apr','Maj','Jun',
        'Jul','Aug','Sep','Okt','Nov','Dec'],
		dayNames: ['SA,ndag','Mandag','Tirsdag','Onsdag','Torsdag','Fredag','LA,rdag'],
		dayNamesShort: ['SA,n','Man','Tir','Ons','Tor','Fre','LA,r'],
		dayNamesMin: ['SA,','Ma','Ti','On','To','Fr','LA,'],
		weekHeader: 'Uge',
        dateFormat: 'dd-mm-yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['da']);
});
���/* German initialisation for the jQuery UI date picker plugin. */
/* Written by Milian Wolff (mail@milianw.de). */
jQuery(function($){
	$.datepicker.regional['de'] = {
		closeText: 'schlieAYen',
		prevText: '&#x3c;zurA�ck',
		nextText: 'Vor&#x3e;',
		currentText: 'heute',
		monthNames: ['Januar','Februar','MArz','April','Mai','Juni',
		'Juli','August','September','Oktober','November','Dezember'],
		monthNamesShort: ['Jan','Feb','MAr','Apr','Mai','Jun',
		'Jul','Aug','Sep','Okt','Nov','Dez'],
		dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
		dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
		dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
		weekHeader: 'Wo',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['de']);
});
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
});/* English/Australia initialisation for the jQuery UI date picker plugin. */
/* Based on the en-GB initialisation. */
jQuery(function($){
	$.datepicker.regional['en-AU'] = {
		closeText: 'Done',
		prevText: 'Prev',
		nextText: 'Next',
		currentText: 'Today',
		monthNames: ['January','February','March','April','May','June',
		'July','August','September','October','November','December'],
		monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
		'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
		dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
		dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
		weekHeader: 'Wk',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['en-AU']);
});
���/* English/UK initialisation for the jQuery UI date picker plugin. */
/* Written by Stuart. */
jQuery(function($){
	$.datepicker.regional['en-GB'] = {
		closeText: 'Done',
		prevText: 'Prev',
		nextText: 'Next',
		currentText: 'Today',
		monthNames: ['January','February','March','April','May','June',
		'July','August','September','October','November','December'],
		monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
		'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
		dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
		dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
		weekHeader: 'Wk',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['en-GB']);
});
/* English/New Zealand initialisation for the jQuery UI date picker plugin. */
/* Based on the en-GB initialisation. */
jQuery(function($){
	$.datepicker.regional['en-NZ'] = {
		closeText: 'Done',
		prevText: 'Prev',
		nextText: 'Next',
		currentText: 'Today',
		monthNames: ['January','February','March','April','May','June',
		'July','August','September','October','November','December'],
		monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
		'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
		dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
		dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
		weekHeader: 'Wk',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['en-NZ']);
});
���/* Esperanto initialisation for the jQuery UI date picker plugin. */
/* Written by Olivier M. (olivierweb@ifrance.com). */
jQuery(function($){
	$.datepicker.regional['eo'] = {
		closeText: 'Fermi',
		prevText: '&lt;Anta',
		nextText: 'Sekv&gt;',
		currentText: 'Nuna',
		monthNames: ['Januaro','Februaro','Marto','Aprilo','Majo','Junio',
		'Julio','A�-gusto','Septembro','Oktobro','Novembro','Decembro'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Maj','Jun',
		'Jul','A�-g','Sep','Okt','Nov','Dec'],
		dayNames: ['Diman�%o','Lundo','Mardo','Merkredo','�'a�-do','Vendredo','Sabato'],
		dayNamesShort: ['Dim','Lun','Mar','Mer','�'a�-','Ven','Sab'],
		dayNamesMin: ['Di','Lu','Ma','Me','�'a','Ve','Sa'],
		weekHeader: 'Sb',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['eo']);
});
/* InicializaciA3n en espaA�ol para la extensiA3n 'UI date picker' para jQuery. */
/* Traducido por Vester (xvester@gmail.com). */
jQuery(function($){
	$.datepicker.regional['es'] = {
		closeText: 'Cerrar',
		prevText: '&#x3c;Ant',
		nextText: 'Sig&#x3e;',
		currentText: 'Hoy',
		monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
		'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
		monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun',
		'Jul','Ago','Sep','Oct','Nov','Dic'],
		dayNames: ['Domingo','Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','S&aacute;bado'],
		dayNamesShort: ['Dom','Lun','Mar','Mi&eacute;','Juv','Vie','S&aacute;b'],
		dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','S&aacute;'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['es']);
});���/* Estonian initialisation for the jQuery UI date picker plugin. */
/* Written by Mart SA�mermaa (mrts.pydev at gmail com). */
jQuery(function($){
	$.datepicker.regional['et'] = {
		closeText: 'Sulge',
		prevText: 'Eelnev',
		nextText: 'JArgnev',
		currentText: 'TAna',
		monthNames: ['Jaanuar','Veebruar','MArts','Aprill','Mai','Juuni',
		'Juuli','August','September','Oktoober','November','Detsember'],
		monthNamesShort: ['Jaan', 'Veebr', 'MArts', 'Apr', 'Mai', 'Juuni',
		'Juuli', 'Aug', 'Sept', 'Okt', 'Nov', 'Dets'],
		dayNames: ['PA�hapAev', 'EsmaspAev', 'TeisipAev', 'KolmapAev', 'NeljapAev', 'Reede', 'LaupAev'],
		dayNamesShort: ['PA�hap', 'Esmasp', 'Teisip', 'Kolmap', 'Neljap', 'Reede', 'Laup'],
		dayNamesMin: ['P','E','T','K','N','R','L'],
		weekHeader: 'Sm',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['et']);
}); ���/* Euskarako oinarria 'UI date picker' jquery-ko extentsioarentzat */
/* Karrikas-ek itzulia (karrikas@karrikas.com) */
jQuery(function($){
	$.datepicker.regional['eu'] = {
		closeText: 'Egina',
		prevText: '&#x3c;Aur',
		nextText: 'Hur&#x3e;',
		currentText: 'Gaur',
		monthNames: ['Urtarrila','Otsaila','Martxoa','Apirila','Maiatza','Ekaina',
		'Uztaila','Abuztua','Iraila','Urria','Azaroa','Abendua'],
		monthNamesShort: ['Urt','Ots','Mar','Api','Mai','Eka',
		'Uzt','Abu','Ira','Urr','Aza','Abe'],
		dayNames: ['Igandea','Astelehena','Asteartea','Asteazkena','Osteguna','Ostirala','Larunbata'],
		dayNamesShort: ['Iga','Ast','Ast','Ast','Ost','Ost','Lar'],
		dayNamesMin: ['Ig','As','As','As','Os','Os','La'],
		weekHeader: 'Wk',
		dateFormat: 'yy/mm/dd',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['eu']);
});���/* Persian (Farsi) Translation for the jQuery UI date picker plugin. */
/* Javad Mowlanezhad -- jmowla@gmail.com */
/* Jalali calendar should supported soon! (Its implemented but I have to test it) */
jQuery(function($) {
	$.datepicker.regional['fa'] = {
		closeText: 'O"O3O�U+',
		prevText: '&#x3c;U,O"U,US',
		nextText: 'O"O1O_US&#x3e;',
		currentText: 'OU.O�U^O�',
		monthNames: ['U_O�U^O�O_USU+','OO�O_USO"U�O'O�','OrO�O_OO_','O�USO�','U.O�O_OO_','O'U�O�USU^O�',
		'U.U�O�','O�O"OU+','O�O�O�','O_US','O"U�U.U+','OO3U_U+O_'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: ['USUcO'U+O"U�','O_U^O'U+O"U�','O3U؃_OO'U+O"U�','U+U�OO�O'U+O"U�','U_U+O�O'U+O"U�','O�U.O1U�','O'U+O"U�'],
		dayNamesShort: ['US','O_','O3','U+','U_','O�', 'O''],
		dayNamesMin: ['US','O_','O3','U+','U_','O�', 'O''],
		weekHeader: 'U�U_',
		dateFormat: 'yy/mm/dd',
		firstDay: 6,
		isRTL: true,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['fa']);
});/* Finnish initialisation for the jQuery UI date picker plugin. */
/* Written by Harri Kilpi��� (harrikilpio@gmail.com). */
jQuery(function($){
    $.datepicker.regional['fi'] = {
		closeText: 'Sulje',
		prevText: '&laquo;Edellinen',
		nextText: 'Seuraava&raquo;',
		currentText: 'T&auml;n&auml;&auml;n',
        monthNames: ['Tammikuu','Helmikuu','Maaliskuu','Huhtikuu','Toukokuu','Kes&auml;kuu',
        'Hein&auml;kuu','Elokuu','Syyskuu','Lokakuu','Marraskuu','Joulukuu'],
        monthNamesShort: ['Tammi','Helmi','Maalis','Huhti','Touko','Kes&auml;',
        'Hein&auml;','Elo','Syys','Loka','Marras','Joulu'],
		dayNamesShort: ['Su','Ma','Ti','Ke','To','Pe','Su'],
		dayNames: ['Sunnuntai','Maanantai','Tiistai','Keskiviikko','Torstai','Perjantai','Lauantai'],
		dayNamesMin: ['Su','Ma','Ti','Ke','To','Pe','La'],
		weekHeader: 'Vk',
        dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['fi']);
});
���/* Faroese initialisation for the jQuery UI date picker plugin */
/* Written by Sverri Mohr Olsen, sverrimo@gmail.com */
jQuery(function($){
	$.datepicker.regional['fo'] = {
		closeText: 'Lat aftur',
		prevText: '&#x3c;Fyrra',
		nextText: 'NA�sta&#x3e;',
		currentText: 'A_ dag',
		monthNames: ['Januar','Februar','Mars','AprA-l','Mei','Juni',
		'Juli','August','September','Oktober','November','Desember'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Mei','Jun',
		'Jul','Aug','Sep','Okt','Nov','Des'],
		dayNames: ['Sunnudagur','MA�nadagur','TA�sdagur','Mikudagur','HA3sdagur','FrA-ggjadagur','Leyardagur'],
		dayNamesShort: ['Sun','MA�n','TA�s','Mik','HA3s','FrA-','Ley'],
		dayNamesMin: ['Su','MA�','TA�','Mi','HA3','Fr','Le'],
		weekHeader: 'Vk',
		dateFormat: 'dd-mm-yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['fo']);
});
���/* Swiss-French initialisation for the jQuery UI date picker plugin. */
/* Written Martin Voelkle (martin.voelkle@e-tc.ch). */
jQuery(function($){
	$.datepicker.regional['fr-CH'] = {
		closeText: 'Fermer',
		prevText: '&#x3c;PrAcc',
		nextText: 'Suiv&#x3e;',
		currentText: 'Courant',
		monthNames: ['Janvier','FAcvrier','Mars','Avril','Mai','Juin',
		'Juillet','AoA�t','Septembre','Octobre','Novembre','DAccembre'],
		monthNamesShort: ['Jan','FAcv','Mar','Avr','Mai','Jun',
		'Jul','AoA�','Sep','Oct','Nov','DAcc'],
		dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],
		dayNamesShort: ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'],
		dayNamesMin: ['Di','Lu','Ma','Me','Je','Ve','Sa'],
		weekHeader: 'Sm',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['fr-CH']);
});���/* French initialisation for the jQuery UI date picker plugin. */
/* Written by Keith Wood (kbwood{at}iinet.com.au),
              StAcphane Nahmani (sholby@sholby.net),
              StAcphane Raimbault <stephane.raimbault@gmail.com> */
jQuery(function($){
	$.datepicker.regional['fr'] = {
		closeText: 'Fermer',
		prevText: 'PrAccAcdent',
		nextText: 'Suivant',
		currentText: 'Aujourd\'hui',
		monthNames: ['Janvier','FAcvrier','Mars','Avril','Mai','Juin',
		'Juillet','AoA�t','Septembre','Octobre','Novembre','DAccembre'],
		monthNamesShort: ['Janv.','FAcvr.','Mars','Avril','Mai','Juin',
		'Juil.','AoA�t','Sept.','Oct.','Nov.','DAcc.'],
		dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],
		dayNamesShort: ['Dim.','Lun.','Mar.','Mer.','Jeu.','Ven.','Sam.'],
		dayNamesMin: ['D','L','M','M','J','V','S'],
		weekHeader: 'Sem.',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['fr']);
});
/* Galician localization for 'UI date picker' jQuery extension. */
/* Translated by Jorge Barreiro <yortx.barry@gmail.com>. */
jQuery(function($){
	$.datepicker.regional['gl'] = {
		closeText: 'Pechar',
		prevText: '&#x3c;Ant',
		nextText: 'Seg&#x3e;',
		currentText: 'Hoxe',
		monthNames: ['Xaneiro','Febreiro','Marzo','Abril','Maio','XuA�o',
		'Xullo','Agosto','Setembro','Outubro','Novembro','Decembro'],
		monthNamesShort: ['Xan','Feb','Mar','Abr','Mai','XuA�',
		'Xul','Ago','Set','Out','Nov','Dec'],
		dayNames: ['Domingo','Luns','Martes','M&eacute;rcores','Xoves','Venres','S&aacute;bado'],
		dayNamesShort: ['Dom','Lun','Mar','M&eacute;r','Xov','Ven','S&aacute;b'],
		dayNamesMin: ['Do','Lu','Ma','M&eacute;','Xo','Ve','S&aacute;'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['gl']);
});���/* Hebrew initialisation for the UI Datepicker extension. */
/* Written by Amir Hardon (ahardon at gmail dot com). */
jQuery(function($){
	$.datepicker.regional['he'] = {
		closeText: 'x�x'xx"',
		prevText: '&#x3c;x"xxx"x_',
		nextText: 'x"x`x_&#x3e;',
		currentText: 'x"xTxx_',
		monthNames: ['xTx�xx_x"','xx`x"xx_x"','xzx"x�','x_xx"xTxo','xzx_xT','xTxx�xT',
		'xTxxoxT','x_xx'xx�x~','x�xx~xzx`x"','x_xxx~xx`x"','x�xx`xzx`x"','x"x�xzx`x"'],
		monthNamesShort: ['1','2','3','4','5','6',
		'7','8','9','10','11','12'],
		dayNames: ['x"x_xcxxY','xcx�xT','xcxoxTxcxT','x"x`xTx�xT','x-xzxTxcxT','xcxTxcxT','xcx`x�'],
		dayNamesShort: ['x_\'','x`\'','x'\'','x"\'','x"\'','x\'','xcx`x�'],
		dayNamesMin: ['x_\'','x`\'','x'\'','x"\'','x"\'','x\'','xcx`x�'],
		weekHeader: 'Wk',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: true,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['he']);
});
���/* Croatian i18n for the jQuery UI date picker plugin. */
/* Written by Vjekoslav Nesek. */
jQuery(function($){
	$.datepicker.regional['hr'] = {
		closeText: 'Zatvori',
		prevText: '&#x3c;',
		nextText: '&#x3e;',
		currentText: 'Danas',
		monthNames: ['Sije�_anj','Velja�_a','O�_ujak','Travanj','Svibanj','Lipanj',
		'Srpanj','Kolovoz','Rujan','Listopad','Studeni','Prosinac'],
		monthNamesShort: ['Sij','Velj','O�_u','Tra','Svi','Lip',
		'Srp','Kol','Ruj','Lis','Stu','Pro'],
		dayNames: ['Nedjelja','Ponedjeljak','Utorak','Srijeda','�Oetvrtak','Petak','Subota'],
		dayNamesShort: ['Ned','Pon','Uto','Sri','�Oet','Pet','Sub'],
		dayNamesMin: ['Ne','Po','Ut','Sr','�Oe','Pe','Su'],
		weekHeader: 'Tje',
		dateFormat: 'dd.mm.yy.',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['hr']);
});/* Hungarian initialisation for the jQuery UI date picker plugin. */
/* Written by Istvan Karaszi (jquery@spam.raszi.hu). */
jQuery(function($){
	$.datepicker.regional['hu'] = {
		closeText: 'bezA�rA�s',
		prevText: '&laquo;&nbsp;vissza',
		nextText: 'el�`re&nbsp;&raquo;',
		currentText: 'ma',
		monthNames: ['JanuA�r', 'FebruA�r', 'MA�rcius', 'A_prilis', 'MA�jus', 'JA�nius',
		'JA�lius', 'Augusztus', 'Szeptember', 'OktA3ber', 'November', 'December'],
		monthNamesShort: ['Jan', 'Feb', 'MA�r', 'A_pr', 'MA�j', 'JA�n',
		'JA�l', 'Aug', 'Szep', 'Okt', 'Nov', 'Dec'],
		dayNames: ['VasA�rnap', 'HActfA', 'Kedd', 'Szerda', 'CsA�tArtAk', 'PAcntek', 'Szombat'],
		dayNamesShort: ['Vas', 'HAct', 'Ked', 'Sze', 'CsA�', 'PAcn', 'Szo'],
		dayNamesMin: ['V', 'H', 'K', 'Sze', 'Cs', 'P', 'Szo'],
		weekHeader: 'HAc',
		dateFormat: 'yy-mm-dd',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['hu']);
});
/* Armenian(UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Levon Zakaryan (levon.zakaryan@gmail.com)*/
jQuery(function($){
	$.datepicker.regional['hy'] = {
		closeText: 'O"O�O_O�O�',
		prevText: '&#x3c;O+O�O-.',
		nextText: 'O_O�O�.&#x3e;',
		currentText: 'O�O�O��.�_',
		monthNames: ['O_O,�,OO_O��_','O"O�O��_O_O��_','O,O��_O�','O�O��_O�O�','O,O�O�O�O�','O_O,�,OO�O�',
		'O_O,�,O�O�O�','OO�O,O�O�O,O�','O_O�O�O�O�O'O�O��_','O_O,O_O�O�O'O�O��_','O+O,O�O�O'O�O��_','O'O�O_O�O�O'O�O��_'],
		monthNamesShort: ['O_O,�,OO_','O"O�O��_','O,O��_O�','O�O��_','O,O�O�O�O�','O_O,�,OO�O�',
		'O_O,�,O�','OO�O�','O_O�O�','O_O,O_','O+O,O�','O'O�O_'],
		dayNames: ['O_O��_O�O_O�','O�O_O,�,O�O�O�OcO�','O��_O��,O�O�O�OcO�','O1O,�_O��,O�O�O�OcO�','O�O�OO�O�O�O�OcO�','O,�,�_O�O�Oc','O�O�O�O�Oc'],
		dayNamesShort: ['O_O��_','O��_O_','O��_�,','O1�_�,','O�OO�','O,�,�_O�','O�O�Oc'],
		dayNamesMin: ['O_O��_','O��_O_','O��_�,','O1�_�,','O�OO�','O,�,�_O�','O�O�Oc'],
		weekHeader: 'O�O�O_',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['hy']);
});/* Indonesian initialisation for the jQuery UI date picker plugin. */
/* Written by Deden Fathurahman (dedenf@gmail.com). */
jQuery(function($){
	$.datepicker.regional['id'] = {
		closeText: 'Tutup',
		prevText: '&#x3c;mundur',
		nextText: 'maju&#x3e;',
		currentText: 'hari ini',
		monthNames: ['Januari','Februari','Maret','April','Mei','Juni',
		'Juli','Agustus','September','Oktober','Nopember','Desember'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Mei','Jun',
		'Jul','Agus','Sep','Okt','Nop','Des'],
		dayNames: ['Minggu','Senin','Selasa','Rabu','Kamis','Jumat','Sabtu'],
		dayNamesShort: ['Min','Sen','Sel','Rab','kam','Jum','Sab'],
		dayNamesMin: ['Mg','Sn','Sl','Rb','Km','jm','Sb'],
		weekHeader: 'Mg',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['id']);
});/* Icelandic initialisation for the jQuery UI date picker plugin. */
/* Written by Haukur H. Thorsson (haukur@eskill.is). */
jQuery(function($){
	$.datepicker.regional['is'] = {
		closeText: 'Loka',
		prevText: '&#x3c; Fyrri',
		nextText: 'N&aelig;sti &#x3e;',
		currentText: '&Iacute; dag',
		monthNames: ['Jan&uacute;ar','Febr&uacute;ar','Mars','Apr&iacute;l','Ma&iacute','J&uacute;n&iacute;',
		'J&uacute;l&iacute;','&Aacute;g&uacute;st','September','Okt&oacute;ber','N&oacute;vember','Desember'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Ma&iacute;','J&uacute;n',
		'J&uacute;l','&Aacute;g&uacute;','Sep','Okt','N&oacute;v','Des'],
		dayNames: ['Sunnudagur','M&aacute;nudagur','&THORN;ri&eth;judagur','Mi&eth;vikudagur','Fimmtudagur','F&ouml;studagur','Laugardagur'],
		dayNamesShort: ['Sun','M&aacute;n','&THORN;ri','Mi&eth;','Fim','F&ouml;s','Lau'],
		dayNamesMin: ['Su','M&aacute;','&THORN;r','Mi','Fi','F&ouml;','La'],
		weekHeader: 'Vika',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['is']);
});/* Italian initialisation for the jQuery UI date picker plugin. */
/* Written by Antonello Pasella (antonello.pasella@gmail.com). */
jQuery(function($){
	$.datepicker.regional['it'] = {
		closeText: 'Chiudi',
		prevText: '&#x3c;Prec',
		nextText: 'Succ&#x3e;',
		currentText: 'Oggi',
		monthNames: ['Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno',
			'Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre'],
		monthNamesShort: ['Gen','Feb','Mar','Apr','Mag','Giu',
			'Lug','Ago','Set','Ott','Nov','Dic'],
		dayNames: ['Domenica','Luned&#236','Marted&#236','Mercoled&#236','Gioved&#236','Venerd&#236','Sabato'],
		dayNamesShort: ['Dom','Lun','Mar','Mer','Gio','Ven','Sab'],
		dayNamesMin: ['Do','Lu','Ma','Me','Gi','Ve','Sa'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['it']);
});
���/* Japanese initialisation for the jQuery UI date picker plugin. */
/* Written by Kentaro SATO (kentaro@ranvis.com). */
jQuery(function($){
	$.datepicker.regional['ja'] = {
		closeText: '�-%a_~a,<',
		prevText: '&#x3c;�%_',
		nextText: '���&#x3e;',
		currentText: '��S�-�',
		monthNames: ['1�o^','2�o^','3�o^','4�o^','5�o^','6�o^',
		'7�o^','8�o^','9�o^','10�o^','11�o^','12�o^'],
		monthNamesShort: ['1�o^','2�o^','3�o^','4�o^','5�o^','6�o^',
		'7�o^','8�o^','9�o^','10�o^','11�o^','12�o^'],
		dayNames: ['�-��>o�-�','�o^�>o�-�','�_��>o�-�','��'�>o�-�','�o"�>o�-�','��`�>o�-�','�oY�>o�-�'],
		dayNamesShort: ['�-�','�o^','�_�','��'','�o"','��`','�oY'],
		dayNamesMin: ['�-�','�o^','�_�','��'','�o"','��`','�oY'],
		weekHeader: '�_�',
		dateFormat: 'yy/mm/dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '�1''};
	$.datepicker.setDefaults($.datepicker.regional['ja']);
});/* Korean initialisation for the jQuery calendar extension. */
/* Written by DaeKwon Kang (ncrash.dk@gmail.com). */
jQuery(function($){
	$.datepicker.regional['ko'] = {
		closeText: '�<��,�',
		prevText: '�_'��,�<�',
		nextText: '�<�_O�<�',
		currentText: '�~�S~',
		monthNames: ['1�>"(JAN)','2�>"(FEB)','3�>"(MAR)','4�>"(APR)','5�>"(MAY)','6�>"(JUN)',
		'7�>"(JUL)','8�>"(AUG)','9�>"(SEP)','10�>"(OCT)','11�>"(NOV)','12�>"(DEC)'],
		monthNamesShort: ['1�>"(JAN)','2�>"(FEB)','3�>"(MAR)','4�>"(APR)','5�>"(MAY)','6�>"(JUN)',
		'7�>"(JUL)','8�>"(AUG)','9�>"(SEP)','10�>"(OCT)','11�>"(NOV)','12�>"(DEC)'],
		dayNames: ['�_�','�>"','�T"','�^~','��c','�,^','�+�'],
		dayNamesShort: ['�_�','�>"','�T"','�^~','��c','�,^','�+�'],
		dayNamesMin: ['�_�','�>"','�T"','�^~','��c','�,^','�+�'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: '�.,'};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
});/* Kazakh (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Dmitriy Karasyov (dmitriy.karasyov@gmail.com). */
jQuery(function($){
	$.datepicker.regional['kz'] = {
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
	$.datepicker.setDefaults($.datepicker.regional['kz']);
});
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
});/* Latvian (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* @author Arturas Paleicikas <arturas.paleicikas@metasite.net> */
jQuery(function($){
	$.datepicker.regional['lv'] = {
		closeText: 'Aizv�"rt',
		prevText: 'Iepr',
		nextText: 'N�_ka',
		currentText: '��odien',
		monthNames: ['Janv�_ris','Febru�_ris','Marts','Apr��lis','Maijs','J��nijs',
		'J��lijs','Augusts','Septembris','Oktobris','Novembris','Decembris'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Mai','J��n',
		'J��l','Aug','Sep','Okt','Nov','Dec'],
		dayNames: ['sv�"tdiena','pirmdiena','otrdiena','tre��diena','ceturtdiena','piektdiena','sestdiena'],
		dayNamesShort: ['svt','prm','otr','tre','ctr','pkt','sst'],
		dayNamesMin: ['Sv','Pr','Ot','Tr','Ct','Pk','Ss'],
		weekHeader: 'Nav',
		dateFormat: 'dd-mm-yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['lv']);
});���/* Malayalam (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Saji Nediyanchath (saji89@gmail.com). */
jQuery(function($){
	$.datepicker.regional['ml'] = {
		closeText: '�'�'��'�',
		prevText: '�'r��_�'"��_�'"�'��_�'��+',  
		nextText: '�'.�'Y��_�'��_�'�'��_ ',
		currentText: '�'؅'"��_�'"��_',
		monthNames: ['�'o�'"��_�'�'��'�','�'���+�'���_�'���_�'�'��'�','�'r�'_�'���_�__�'s��_�'s��_','�'_�'���_�'��'��'���_�__','�'r��؅'_��_','�'o��,�'���_�__',
		'�'o��,�'���^','�'+�'-�',��_�'��_�'��_','�',��+�'���_�'��_�'�',�'��'���_�__','�''�'��_�'Y��<�'��'���_�__','�'"�'�',�'��'���_�__','�'��'��',�',�'��'���_�__'],
		monthNamesShort: ['�'o�'"��_', '�'���+�'���_', '�'r�'_�'���_�__', '�'_�'���_�'��'�', '�'r��؅'_��_', '�'o��,�'���_�__',
		'�'o��,�'��'_', '�'+�'-', '�',��+�'���_', '�''�'��_�'Y��<', '�'"�'�',', '�'��'��','],
		dayNames: ['�'z�'_�'_�'���_�__', '�'�'��'T��_�'�'3��_�__', '�'s��S�'��_�'�', '�'���_�'�'"��_�__', '�'��_�'_�'_�''�',', '�'��+�'3��_�'3�'�', '�'�'"�'�'],
		dayNamesShort: ['�'z�'_�'_', '�'�'��'T��_�'', '�'s��S�'��_�'�', '�'���_�'', '�'��_�'_�'_�''�',', '�'��+�'3��_�'3�'�', '�'�'"�'�'],
		dayNamesMin: ['�'z�'_','�'�'�','�'s��S','�'���_','�'��_�'_�'_','�'��+','�''],
		weekHeader: '�'+',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ml']);
});
/* Malaysian initialisation for the jQuery UI date picker plugin. */
/* Written by Mohd Nawawi Mohamad Jamili (nawawi@ronggeng.net). */
jQuery(function($){
	$.datepicker.regional['ms'] = {
		closeText: 'Tutup',
		prevText: '&#x3c;Sebelum',
		nextText: 'Selepas&#x3e;',
		currentText: 'hari ini',
		monthNames: ['Januari','Februari','Mac','April','Mei','Jun',
		'Julai','Ogos','September','Oktober','November','Disember'],
		monthNamesShort: ['Jan','Feb','Mac','Apr','Mei','Jun',
		'Jul','Ogo','Sep','Okt','Nov','Dis'],
		dayNames: ['Ahad','Isnin','Selasa','Rabu','Khamis','Jumaat','Sabtu'],
		dayNamesShort: ['Aha','Isn','Sel','Rab','kha','Jum','Sab'],
		dayNamesMin: ['Ah','Is','Se','Ra','Kh','Ju','Sa'],
		weekHeader: 'Mg',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ms']);
});���/* Dutch (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Mathias Bynens <http://mathiasbynens.be/> */
jQuery(function($){
	$.datepicker.regional.nl = {
		closeText: 'Sluiten',
		prevText: '�+_',
		nextText: '�+'',
		currentText: 'Vandaag',
		monthNames: ['januari', 'februari', 'maart', 'april', 'mei', 'juni',
		'juli', 'augustus', 'september', 'oktober', 'november', 'december'],
		monthNamesShort: ['jan', 'feb', 'maa', 'apr', 'mei', 'jun',
		'jul', 'aug', 'sep', 'okt', 'nov', 'dec'],
		dayNames: ['zondag', 'maandag', 'dinsdag', 'woensdag', 'donderdag', 'vrijdag', 'zaterdag'],
		dayNamesShort: ['zon', 'maa', 'din', 'woe', 'don', 'vri', 'zat'],
		dayNamesMin: ['zo', 'ma', 'di', 'wo', 'do', 'vr', 'za'],
		weekHeader: 'Wk',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional.nl);
});/* Norwegian initialisation for the jQuery UI date picker plugin. */
/* Written by Naimdjon Takhirov (naimdjon@gmail.com). */

jQuery(function($){
  $.datepicker.regional['no'] = {
    closeText: 'Lukk',
    prevText: '&laquo;Forrige',
    nextText: 'Neste&raquo;',
    currentText: 'I dag',
    monthNames: ['januar','februar','mars','april','mai','juni','juli','august','september','oktober','november','desember'],
    monthNamesShort: ['jan','feb','mar','apr','mai','jun','jul','aug','sep','okt','nov','des'],
    dayNamesShort: ['sA,n','man','tir','ons','tor','fre','lA,r'],
    dayNames: ['sA,ndag','mandag','tirsdag','onsdag','torsdag','fredag','lA,rdag'],
    dayNamesMin: ['sA,','ma','ti','on','to','fr','lA,'],
    weekHeader: 'Uke',
    dateFormat: 'dd.mm.yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  };
  $.datepicker.setDefaults($.datepicker.regional['no']);
});
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
/* Brazilian initialisation for the jQuery UI date picker plugin. */
/* Written by Leonildo Costa Silva (leocsilva@gmail.com). */
jQuery(function($){
	$.datepicker.regional['pt-BR'] = {
		closeText: 'Fechar',
		prevText: '&#x3c;Anterior',
		nextText: 'Pr&oacute;ximo&#x3e;',
		currentText: 'Hoje',
		monthNames: ['Janeiro','Fevereiro','Mar&ccedil;o','Abril','Maio','Junho',
		'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun',
		'Jul','Ago','Set','Out','Nov','Dez'],
		dayNames: ['Domingo','Segunda-feira','Ter&ccedil;a-feira','Quarta-feira','Quinta-feira','Sexta-feira','S&aacute;bado'],
		dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','S&aacute;b'],
		dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','S&aacute;b'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['pt-BR']);
});/* Portuguese initialisation for the jQuery UI date picker plugin. */
jQuery(function($){
	$.datepicker.regional['pt'] = {
		closeText: 'Fechar',
		prevText: '&#x3c;Anterior',
		nextText: 'Seguinte',
		currentText: 'Hoje',
		monthNames: ['Janeiro','Fevereiro','Mar&ccedil;o','Abril','Maio','Junho',
		'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun',
		'Jul','Ago','Set','Out','Nov','Dez'],
		dayNames: ['Domingo','Segunda-feira','Ter&ccedil;a-feira','Quarta-feira','Quinta-feira','Sexta-feira','S&aacute;bado'],
		dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','S&aacute;b'],
		dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','S&aacute;b'],
		weekHeader: 'Sem',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['pt']);
});/* Romansh initialisation for the jQuery UI date picker plugin. */
/* Written by Yvonne Gienal (yvonne.gienal@educa.ch). */
jQuery(function($){
	$.datepicker.regional['rm'] = {
		closeText: 'Serrar',
		prevText: '&#x3c;Suandant',
		nextText: 'Precedent&#x3e;',
		currentText: 'Actual',
		monthNames: ['Schaner','Favrer','Mars','Avrigl','Matg','Zercladur', 'Fanadur','Avust','Settember','October','November','December'],
		monthNamesShort: ['Scha','Fev','Mar','Avr','Matg','Zer', 'Fan','Avu','Sett','Oct','Nov','Dec'],
		dayNames: ['Dumengia','Glindesdi','Mardi','Mesemna','Gievgia','Venderdi','Sonda'],
		dayNamesShort: ['Dum','Gli','Mar','Mes','Gie','Ven','Som'],
		dayNamesMin: ['Du','Gl','Ma','Me','Gi','Ve','So'],
		weekHeader: 'emna',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['rm']);
});
���/* Romanian initialisation for the jQuery UI date picker plugin.
 *
 * Written by Edmond L. (ll_edmond@walla.com)
 * and Ionut G. Stan (ionut.g.stan@gmail.com)
 */
jQuery(function($){
	$.datepicker.regional['ro'] = {
		closeText: 'AZnchide',
		prevText: '&laquo; Luna precedent��',
		nextText: 'Luna urm��toare &raquo;',
		currentText: 'Azi',
		monthNames: ['Ianuarie','Februarie','Martie','Aprilie','Mai','Iunie',
		'Iulie','August','Septembrie','Octombrie','Noiembrie','Decembrie'],
		monthNamesShort: ['Ian', 'Feb', 'Mar', 'Apr', 'Mai', 'Iun',
		'Iul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		dayNames: ['Duminic��', 'Luni', 'Mar��i', 'Miercuri', 'Joi', 'Vineri', 'SA�mb��t��'],
		dayNamesShort: ['Dum', 'Lun', 'Mar', 'Mie', 'Joi', 'Vin', 'SA�m'],
		dayNamesMin: ['Du','Lu','Ma','Mi','Jo','Vi','SA�'],
		weekHeader: 'S��pt',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ro']);
});
/* Russian (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Andrew Stromnov (stromnov@gmail.com). */
jQuery(function($){
	$.datepicker.regional['ru'] = {
		closeText: 'D-D�D��_�<�,�O',
		prevText: '&#x3c;DY�_D�D'',
		nextText: 'D�D�D�D'&#x3e;',
		currentText: 'D�D�D3D_D'D��_',
		monthNames: ['D_D�D�D��_�O','DD�D��_D�D��O','DoD��_�,','D_D��_D�D��O','DoD�D1','D~�ZD��O',
		'D~�ZD��O','D_D�D3���_�,','D�D�D��,�_D�_�O','DzD��,�_D�_�O','D_D_�_D�_�O','D"D�D�D�D�_�O'],
		monthNamesShort: ['D_D�D�','DD�D�','DoD��_','D_D��_','DoD�D1','D~�ZD�',
		'D~�ZD�','D_D�D3','D�D�D�','DzD��,','D_D_�_','D"D�D�'],
		dayNames: ['D�D_�_D��_D�_D�D��OD�','D�D_D�D�D'D�D��OD�D,D�','D��,D_�_D�D,D�','�_�_D�D'D�','��D�,D�D�_D3','D��_�,D�D,�+D�','�_��D�D�D_�,D�'],
		dayNamesShort: ['D��_D�','D�D�D'','D��,�_','�_�_D'','�إ,D�','D��,D�','�_D�,'],
		dayNamesMin: ['D'�_','DYD�','D'�,','D��_','D�,','DY�,','D�D�'],
		weekHeader: 'D_D�D'',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ru']);
});/* Slovak initialisation for the jQuery UI date picker plugin. */
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
		dayNames: ['Nedel\'a','Pondelok','Utorok','Streda','��tvrtok','Piatok','Sobota'],
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
/* Slovenian initialisation for the jQuery UI date picker plugin. */
/* Written by Jaka Jancar (jaka@kubje.org). */
/* c = &#x10D;, s = &#x161; z = &#x17E; C = &#x10C; S = &#x160; Z = &#x17D; */
jQuery(function($){
	$.datepicker.regional['sl'] = {
		closeText: 'Zapri',
		prevText: '&lt;Prej&#x161;nji',
		nextText: 'Naslednji&gt;',
		currentText: 'Trenutni',
		monthNames: ['Januar','Februar','Marec','April','Maj','Junij',
		'Julij','Avgust','September','Oktober','November','December'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Maj','Jun',
		'Jul','Avg','Sep','Okt','Nov','Dec'],
		dayNames: ['Nedelja','Ponedeljek','Torek','Sreda','&#x10C;etrtek','Petek','Sobota'],
		dayNamesShort: ['Ned','Pon','Tor','Sre','&#x10C;et','Pet','Sob'],
		dayNamesMin: ['Ne','Po','To','Sr','&#x10C;e','Pe','So'],
		weekHeader: 'Teden',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['sl']);
});
���/* Albanian initialisation for the jQuery UI date picker plugin. */
/* Written by Flakron Bytyqi (flakron@gmail.com). */
jQuery(function($){
	$.datepicker.regional['sq'] = {
		closeText: 'mbylle',
		prevText: '&#x3c;mbrapa',
		nextText: 'PA�rpara&#x3e;',
		currentText: 'sot',
		monthNames: ['Janar','Shkurt','Mars','Prill','Maj','Qershor',
		'Korrik','Gusht','Shtator','Tetor','NA�ntor','Dhjetor'],
		monthNamesShort: ['Jan','Shk','Mar','Pri','Maj','Qer',
		'Kor','Gus','Sht','Tet','NA�n','Dhj'],
		dayNames: ['E Diel','E HA�nA�','E MartA�','E MA�rkurA�','E Enjte','E Premte','E Shtune'],
		dayNamesShort: ['Di','HA�','Ma','MA�','En','Pr','Sh'],
		dayNamesMin: ['Di','HA�','Ma','MA�','En','Pr','Sh'],
		weekHeader: 'Ja',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['sq']);
});
���/* Serbian i18n for the jQuery UI date picker plugin. */
/* Written by Dejan Dimi��. */
jQuery(function($){
	$.datepicker.regional['sr-SR'] = {
		closeText: 'Zatvori',
		prevText: '&#x3c;',
		nextText: '&#x3e;',
		currentText: 'Danas',
		monthNames: ['Januar','Februar','Mart','April','Maj','Jun',
		'Jul','Avgust','Septembar','Oktobar','Novembar','Decembar'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','Maj','Jun',
		'Jul','Avg','Sep','Okt','Nov','Dec'],
		dayNames: ['Nedelja','Ponedeljak','Utorak','Sreda','�Oetvrtak','Petak','Subota'],
		dayNamesShort: ['Ned','Pon','Uto','Sre','�Oet','Pet','Sub'],
		dayNamesMin: ['Ne','Po','Ut','Sr','�Oe','Pe','Su'],
		weekHeader: 'Sed',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['sr-SR']);
});
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
���/* Swedish initialisation for the jQuery UI date picker plugin. */
/* Written by Anders Ekdahl ( anders@nomadiz.se). */
jQuery(function($){
    $.datepicker.regional['sv'] = {
		closeText: 'StAng',
        prevText: '&laquo;FArra',
		nextText: 'NAsta&raquo;',
		currentText: 'Idag',
        monthNames: ['Januari','Februari','Mars','April','Maj','Juni',
        'Juli','Augusti','September','Oktober','November','December'],
        monthNamesShort: ['Jan','Feb','Mar','Apr','Maj','Jun',
        'Jul','Aug','Sep','Okt','Nov','Dec'],
		dayNamesShort: ['SAn','MA�n','Tis','Ons','Tor','Fre','LAr'],
		dayNames: ['SAndag','MA�ndag','Tisdag','Onsdag','Torsdag','Fredag','LArdag'],
		dayNamesMin: ['SA','MA�','Ti','On','To','Fr','LA'],
		weekHeader: 'Ve',
        dateFormat: 'yy-mm-dd',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['sv']);
});
���/* Tamil (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by S A Sureshkumar (saskumar@live.com). */
jQuery(function($){
	$.datepicker.regional['ta'] = {
		closeText: '�rr�_,�rY�__',
		prevText: '�rr�__�rc�__�rc�_^�r_�r�__',
		nextText: '�r.�rY�__�r�__�r�r�__',
		currentText: '�r؅rc�__�r�__',
		monthNames: ['�r�_^','�rr�r_�rs�r�','�r��rT�__�r�__�rc�r�','�rs�r��r�__�r�r��r��_^','�r�_^�r�r_�rs�r�','�r+�rc�r�',
		'�r+�rY�r�','�r+�r�r��r�','�r��__�r��rY�__�rY�r_�rs�r�','�r_�r��__�r��rs�r�','�r�r_�r��__�r�__�r�r��r�_^','�rr�r_�r��__�r�r'�r�'],
		monthNamesShort: ['�r�_^','�rr�r_�rs�r�','�r��rT�__','�rs�r��r�__','�r�_^�r�r_','�r+�rc�r�',
		'�r+�rY�r�','�r+�r�','�r��__�r�','�r_�r��__','�r�r_�r��__','�rr�r_�r��__'],
		dayNames: ['�rz�r_�r_�r��r�__�r�__�r�__�r�r��r'�rr�_^','�r�r��rT�__�r�rY�__�r�r��r'�rr�_^','�rs�_+�r�__�r�r_�r_�__�r�__�r�r��r'�rr�_^','�r��__�r�rc�__�r�r��r'�rr�_^','�r�r��r_�r_�r'�r�__�r�r��r'�rr�_^','�r�_+�r3�__�r3�r��r�__�r�r��r'�rr�_^','�rs�rc�r��r�__�r�r��r'�rr�_^'],
		dayNamesShort: ['�rz�r_�r_�r��r�__','�r�r��rT�__�r�r3�__','�rs�_+�r�__�r�r_�r_�__','�r��__�r�rc�__','�r�r��r_�r_�r'�rc�__','�r�_+�r3�__�r3�r�','�rs�rc�r�'],
		dayNamesMin: ['�rz�r_','�r�r�','�rs�_+','�r��__','�r�r�','�r�_+','�rs'],
		weekHeader: 'D_D�',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ta']);
});
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
});/* Turkish initialisation for the jQuery UI date picker plugin. */
/* Written by Izzet Emre Erkan (kara@karalamalar.net). */
jQuery(function($){
	$.datepicker.regional['tr'] = {
		closeText: 'kapat',
		prevText: '&#x3c;geri',
		nextText: 'ileri&#x3e',
		currentText: 'bugA�n',
		monthNames: ['Ocak','�zubat','Mart','Nisan','May��s','Haziran',
		'Temmuz','A�Yustos','EylA�l','Ekim','Kas��m','Aral��k'],
		monthNamesShort: ['Oca','�zub','Mar','Nis','May','Haz',
		'Tem','A�Yu','Eyl','Eki','Kas','Ara'],
		dayNames: ['Pazar','Pazartesi','Sal��','A�ar�Yamba','Per�Yembe','Cuma','Cumartesi'],
		dayNamesShort: ['Pz','Pt','Sa','A�a','Pe','Cu','Ct'],
		dayNamesMin: ['Pz','Pt','Sa','A�a','Pe','Cu','Ct'],
		weekHeader: 'Hf',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['tr']);
});/* Ukrainian (UTF-8) initialisation for the jQuery UI date picker plugin. */
/* Written by Maxim Drogobitskiy (maxdao@gmail.com). */
jQuery(function($){
	$.datepicker.regional['uk'] = {
		closeText: 'D-D�D��_D,�,D,',
		prevText: '&#x3c;',
		nextText: '&#x3e;',
		currentText: 'D��OD_D3D_D'D��-',
		monthNames: ['D��-��D�D��O','D>�Z�,D,D1','D`D�_D�D�D�D��O','DsD��-�,D�D��O','D��_D�D�D�D��O','DD�_D�D�D��O',
		'D>D,D�D�D��O','D�D�_D�D�D��O','D'D�_D�_D�D��O','D-D_D��,D�D��O','D>D,�_�,D_D�D�D'','D"�_��D'D�D��O'],
		monthNamesShort: ['D��-��','D>�Z�,','D`D�_','DsD��-','D��_D�','DD�_',
		'D>D,D�','D�D�_','D'D�_','D-D_D�','D>D,�_','D"�_��'],
		dayNames: ['D�D�D'�-D��_','D�D_D�D�D'�-D�D_D�','D��-D��,D_�_D_D�','�_D�_D�D'D�','��D�,D�D�_','D��_T�_�,D�D,�+�_','�_��D�D_�,D�'],
		dayNamesShort: ['D�D�D'','D�D�D'','D��-D�','�_�_D'','�إ,D�','D��,D�','�_D�,'],
		dayNamesMin: ['D_D'','DYD�','D'�,','D��_','D�,','DY�,','D�D�'],
		weekHeader: 'D_D�',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['uk']);
});���/* Vietnamese initialisation for the jQuery UI date picker plugin. */
/* Translated by Le Thanh Huy (lthanhhuy@cit.ctu.edu.vn). */
jQuery(function($){
	$.datepicker.regional['vi'] = {
		closeText: '�_A3ng',
		prevText: '&#x3c;Tr����>c',
		nextText: 'Ti���p&#x3e;',
		currentText: 'HA'm nay',
		monthNames: ['ThA�ng M��Tt', 'ThA�ng Hai', 'ThA�ng Ba', 'ThA�ng T��', 'ThA�ng N��m', 'ThA�ng SA�u',
		'ThA�ng B���y', 'ThA�ng TA�m', 'ThA�ng ChA-n', 'ThA�ng M����_i', 'ThA�ng M����_i M��Tt', 'ThA�ng M����_i Hai'],
		monthNamesShort: ['ThA�ng 1', 'ThA�ng 2', 'ThA�ng 3', 'ThA�ng 4', 'ThA�ng 5', 'ThA�ng 6',
		'ThA�ng 7', 'ThA�ng 8', 'ThA�ng 9', 'ThA�ng 10', 'ThA�ng 11', 'ThA�ng 12'],
		dayNames: ['Ch�� Nh��-t', 'Th��c Hai', 'Th��c Ba', 'Th��c T��', 'Th��c N��m', 'Th��c SA�u', 'Th��c B���y'],
		dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
		dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
		weekHeader: 'Tu',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['vi']);
});
/* Chinese initialisation for the jQuery UI date picker plugin. */
/* Written by Cloudream (cloudream@gmail.com). */
jQuery(function($){
	$.datepicker.regional['zh-CN'] = {
		closeText: '�.3�--',
		prevText: '&#x3c;�,S�o^',
		nextText: '�,<�o^&#x3e;',
		currentText: '��S�c',
		monthNames: ['�,_�o^','��O�o^','�,%�o^','�>>�o^','��"�o^','�.-�o^',
		'�,��o^','�.��o^','�1_�o^','�__�o^','�__�,_�o^','�__��O�o^'],
		monthNamesShort: ['�,_','��O','�,%','�>>','��"','�.-',
		'�,�','�.�','�1_','�__','�__�,_','�__��O'],
		dayNames: ['�~Y�oY�-�','�~Y�oY�,_','�~Y�oY��O','�~Y�oY�,%','�~Y�oY�>>','�~Y�oY��"','�~Y�oY�.-'],
		dayNamesShort: ['�`"�-�','�`"�,_','�`"��O','�`"�,%','�`"�>>','�`"��"','�`"�.-'],
		dayNamesMin: ['�-�','�,_','��O','�,%','�>>','��"','�.-'],
		weekHeader: '�`"',
		dateFormat: 'yy-mm-dd',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '�1''};
	$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
});
/* Chinese initialisation for the jQuery UI date picker plugin. */
/* Written by SCCY (samuelcychan@gmail.com). */
jQuery(function($){
	$.datepicker.regional['zh-HK'] = {
		closeText: '�-o�-%',
		prevText: '&#x3c;�,S�o^',
		nextText: '�,<�o^&#x3e;',
		currentText: '��S�c',
		monthNames: ['�,_�o^','��O�o^','�,%�o^','�>>�o^','��"�o^','�.-�o^',
		'�,��o^','�.��o^','�1_�o^','�__�o^','�__�,_�o^','�__��O�o^'],
		monthNamesShort: ['�,_','��O','�,%','�>>','��"','�.-',
		'�,�','�.�','�1_','�__','�__�,_','�__��O'],
		dayNames: ['�~Y�oY�-�','�~Y�oY�,_','�~Y�oY��O','�~Y�oY�,%','�~Y�oY�>>','�~Y�oY��"','�~Y�oY�.-'],
		dayNamesShort: ['�`"�-�','�`"�,_','�`"��O','�`"�,%','�`"�>>','�`"��"','�`"�.-'],
		dayNamesMin: ['�-�','�,_','��O','�,%','�>>','��"','�.-'],
		weekHeader: '�`"',
		dateFormat: 'dd-mm-yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '�1''};
	$.datepicker.setDefaults($.datepicker.regional['zh-HK']);
});
���/* Chinese initialisation for the jQuery UI date picker plugin. */
/* Written by Ressol (ressol@gmail.com). */
jQuery(function($){
	$.datepicker.regional['zh-TW'] = {
		closeText: '�-o�-%',
		prevText: '&#x3c;�,S�o^',
		nextText: '�,<�o^&#x3e;',
		currentText: '��S�c',
		monthNames: ['�,_�o^','��O�o^','�,%�o^','�>>�o^','��"�o^','�.-�o^',
		'�,��o^','�.��o^','�1_�o^','�__�o^','�__�,_�o^','�__��O�o^'],
		monthNamesShort: ['�,_','��O','�,%','�>>','��"','�.-',
		'�,�','�.�','�1_','�__','�__�,_','�__��O'],
		dayNames: ['�~Y�oY�-�','�~Y�oY�,_','�~Y�oY��O','�~Y�oY�,%','�~Y�oY�>>','�~Y�oY��"','�~Y�oY�.-'],
		dayNamesShort: ['�`"�-�','�`"�,_','�`"��O','�`"�,%','�`"�>>','�`"��"','�`"�.-'],
		dayNamesMin: ['�-�','�,_','��O','�,%','�>>','��"','�.-'],
		weekHeader: '�`"',
		dateFormat: 'yy/mm/dd',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '�1''};
	$.datepicker.setDefaults($.datepicker.regional['zh-TW']);
});


