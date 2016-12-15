var reporteVariantesPasos = function(){
	this.crearVariantesPasos = function(Op){
		//console.log(Op)
		crearVariantesPasos(Op);
	}


	var crearVariantesPasos = function(Op){
		var deSistema 				= $('#filtrosConversiones option:selected').attr('desistema');
		var idConfiguracionReporte	= 0;
		var tituloVentana			= 'Nueva variante de reporte';	

 		if(Op == 1){
			SalesUp.Variables.idConfiguracionReporte = $('#filtrosConversiones').val();
			tituloVentana                            = 'Editar variante de reporte';
		}

		SalesUp.Construye.MuestraPopUp({
	      alto:'450', ancho:'650px', id:'popUpVarianteReporte',
	      titulo:tituloVentana, 
	      fuente:'/privado/popup_crea_variantes_pasos.dbsp'
	    });
	}


}


