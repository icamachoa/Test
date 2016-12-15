/* Bulgarian initialisation for the jQuery UI date picker plugin. */
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


