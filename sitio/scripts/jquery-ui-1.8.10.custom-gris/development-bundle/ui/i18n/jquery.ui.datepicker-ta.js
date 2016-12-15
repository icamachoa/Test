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


