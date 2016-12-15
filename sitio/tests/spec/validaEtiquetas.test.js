
var testing = (window.opener != null) ? window.opener.test : null, arrTest = [], respTest;

describe('test popup etiquetas', function(){

	beforeAll(function(done){
		

		$('#ListaFiltros #agregarFiltro').click();
		$('#FiltroTipo').val(1).change();

		setTimeout(function() {
			$('#FiltroDetalle').val(0).change();
			setTimeout(function () {
				var dataJson = SalesUp.Variables.jsonprospectos || SalesUp.Variables.jsonoportunidad;
				SalesUp.Variables.Tkp = dataJson.JsonDatos[0].Tkp;

				var buttonContainer = 'tr .btnNeutral[tkp="' + SalesUp.Variables.Tkp + '"]';
				$(buttonContainer).mouseenter();
				//console.log('preparando el menu de acciones multiples');
				done();
			}, 2000)
		}, 2000)
	}, 5000);

	respTest = it('Existe la funcion "ETIQUETAR" en las opciones', function(done) {
		//console.log('validamos que exista la funcion de "Etiquetar"');
		expect(typeof SalesUp.Variables.accionesComunes.etiquetar).toEqual('function');
		done();
	});

	arrTest.push(respTest);

	respTest = it('Mostramos el modal de etiquetar', function(done) {
		setTimeout(function(){
			SalesUp.Variables.accionesComunes.etiquetar({Tkp: SalesUp.Variables.Tkp, callback: ReloadData});
			var existeModal = $('#popEtiquetarContacto') ? true : false;
			//console.log('validamos que se ha desplegado el modal');
			expect(existeModal).toBeTruthy();
			done();
		}, 2000);		
	});

	arrTest.push(respTest);

	respTest = it('Existe la funcion "GUARDAR ETIQUETA"', function(done){
		//console.log('Validamos que exista la funcion de "Guardar etiqueta"');
		expect(typeof SalesUp.Variables.accionesComunes.guardarEtiquetas).toEqual('function');
		done();
	});

	arrTest.push(respTest);

	respTest = it('Validamos los datos del prospecto y que no tenga etiquetas iniciales', function(done) {
		//console.log('Validamos los datos del prospecto');
		setTimeout(function(){
			var $popup = $('#frmEtiquetas');
			var datosPopup = {};
			datosPopup.username = $popup.find('#username').text();
			datosPopup.empresa = $popup.find('#empresa').text();
			datosPopup.etiquetas = $popup.find('#etiquetas').val();

			var dataJson = SalesUp.Variables.jsonprospectos || SalesUp.Variables.jsonoportunidad;
			var data = dataJson.JsonDatos[0];

			expect(datosPopup.username).toEqual(data.NombreCliente);
			expect(datosPopup.empresa).toEqual(data.Empresa);
			//console.log(datosPopup.etiquetas);
			if(datosPopup.etiquetas != ''){
				//Si existen etiquetas previas automatizamos el proceso de borrarlas y al finalizar 
				//el test las regresamos a como estaban originalmente
				//console.log('Si tiene etiquetas originales las guardamos y reiniciamos');
				SalesUp.Variables.etiquetasOriginales = datosPopup.etiquetas;
				var $select = $('#etiquetas');
				var selectize = $select[0].selectize;

				selectize.clear();
				$('#BtnAceptar').click();
				setTimeout(function(){
					SalesUp.Variables.accionesComunes.etiquetar({Tkp: SalesUp.Variables.Tkp, callback: ReloadData});
					done();
				}, 2000);
			} else {
				SalesUp.Variables.etiquetasOriginales = '';
				done();
			}
		}, 1000)
	});

	arrTest.push(respTest);

	

	respTest = it('Construimos las nuevas etiquetas', function(done){
		setTimeout(function(){
			//console.log('construimos las etiquetas nuevas');
			var $select = $('#etiquetas');
			var selectize = $select[0].selectize;
			//agregamos las primeras n etiquetas siempre y cuando sea posible, además de guardar los objetos para la validación después del post
			SalesUp.Variables.numEtiquetasPrueba = 2;
			SalesUp.Variables.etiquetasPrueba = [];
			for(var i=0; i < SalesUp.Variables.numEtiquetasPrueba; i++){
				selectize.addItem(SalesUp.Variables.etiquetas[i].IdEtiqueta);
				SalesUp.Variables.etiquetasPrueba.push(SalesUp.Variables.etiquetas[i]);
			}
			
			expect(SalesUp.Variables.etiquetasPrueba.length).toEqual(2);
			done();
		}, 2000);
	});

	arrTest.push(respTest);

	respTest = it('Validamos que guarde las etiquetas', function(done){
		$('#BtnAceptar').click();		//Hacemos la llamada a guardar etiquetas
		//Validamos que las etiquetas que tiene el usuario con el Tkp indicado sean las mismas que nosotros
		//guardamos, revisando previamente el objeto etiquetasPrueba
		setTimeout(function(){
			//console.log('guardamos las etiquetas nuevas');
			var etiquetasNuevas = $("tr[data-tk='" + SalesUp.Variables.Tkp +"'] td ul.tags li a");
			expect(etiquetasNuevas.length).toEqual(SalesUp.Variables.etiquetasPrueba.length);

			for(var i=0; i < etiquetasNuevas.length; i++){
				expect($(etiquetasNuevas[i]).text()).toEqual(SalesUp.Variables.etiquetasPrueba[i].Etiqueta);
			}
			done();
		}, 2000);
	});

	arrTest.push(respTest);

	respTest = it('Validamos que elimine las etiquetas', function(done){
		SalesUp.Variables.accionesComunes.etiquetar({Tkp: SalesUp.Variables.Tkp, callback: ReloadData});
		setTimeout(function(){
			//console.log('Eliminamos la primera etiqueta');
			var $select = $('#etiquetas');
			var selectize = $select[0].selectize;

			//Eliminamos la primera etiqueta y el objeto etiqueta de igual manera
			selectize.removeItem(SalesUp.Variables.etiquetasPrueba[0].IdEtiqueta);
			SalesUp.Variables.etiquetasPrueba.shift();
			$('#BtnAceptar').click();

			setTimeout(function(){
				var etiquetasNuevas = $("tr[data-tk='" + SalesUp.Variables.Tkp +"'] td ul.tags li a");
				expect(etiquetasNuevas.length).toEqual(SalesUp.Variables.etiquetasPrueba.length);
				done();
			}, 2000);
		}, 2000);
	});

	arrTest.push(respTest);

	afterAll(function(done) {
		SalesUp.Variables.accionesComunes.etiquetar({Tkp: SalesUp.Variables.Tkp, callback: ReloadData});
		setTimeout(function(){
			//console.log('recuperamos las etiquetas originales');
			var $select = $('#etiquetas');
			var selectize = $select[0].selectize;

			selectize.clear();
			var etiquetasOriginales = SalesUp.Variables.etiquetasOriginales.split(',');

			for(var i = 0; i < etiquetasOriginales.length; i++){
				selectize.addItem(etiquetasOriginales[i]);
			}
			
			$('#BtnAceptar').click();
			setTimeout(function(){
				expect(etiquetasOriginales.length).toEqual(SalesUp.Variables.etiquetasOriginales.split(',').length);
				$('#eliminarFiltros').click();
				done();
			}, 2000);
		}, 2000);

		if (testing) {
			testing.guardaRespuesta(arrTest,1, window);
		}else{
			return;
		}		

	});
});