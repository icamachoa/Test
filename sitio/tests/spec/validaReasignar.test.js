jasmine.DEFAULT_TIMEOUT_INTERVAL =15000;

var testing = (window.opener != null) ? window.opener.test : null, arrTest = [], respTest;

describe('test popup reasignar', function(){
	beforeAll(function(done) {

		//console.log('preparando los filtros para la lista de prospectos');
		//Preparamos la ubicacion para saber de donde vienen las pruebas
		setTimeout(function() {
			SalesUp.Variables.origen = (SalesUp.Variables.jsonprospectos != undefined) ? 'prospectos' : 'oportunidades';

			$('#ListaFiltros #agregarFiltro').click();
			$('#FiltroTipo').val(1).change();
			setTimeout(function() {
				$('#FiltroDetalle').val(0).change();
				setTimeout(function() {
				//console.log('preparando el menu de acciones multiples');
				var dataJson = SalesUp.Variables.jsonprospectos || SalesUp.Variables.jsonoportunidad;
				SalesUp.Variables.Tkp = dataJson.JsonDatos[0].Tkp;
				SalesUp.Variables.Tko = dataJson.JsonDatos[0].Tko;
				SalesUp.Variables.ejecutivoOriginal = dataJson.JsonDatos[0].IdUsuario;
				console.log('IdUsuario: ' + SalesUp.Variables.ejecutivoOriginal);
				var buttonContainer = 'tr .btnNeutral[tkp="' + SalesUp.Variables.Tkp + '"]';
				$(buttonContainer).mouseenter();

				done();
			}, 3000);
			}, 3000);
		},2000);
		
	},14000);

	respTest = it('Existe la funcion "REASIGNAR" en las opciones', function(done) {
		//console.log('Validamos que exista la funcion de "REASIGNAR"');
		expect(typeof SalesUp.Variables.accionesComunes.reasignar).toEqual('function');
		done();
	});

	arrTest.push(respTest);

	respTest = it('Mostramos el modal de reasignar', function(done) {
		setTimeout(function() {
			SalesUp.Variables.accionesComunes.reasignar({Tkp: SalesUp.Variables.Tkp, Tko: SalesUp.Variables.Tko, titulo: 'Reasignar el prospecto a otro ejecutivo', callback: ReloadData});
			var existeModal = $('#popReasignarContacto') ? true : false;
			//console.log('Validamos que exista el modal y se despliegue');
			expect(existeModal).toBeTruthy();
			done();
		}, 3000);
	});

	arrTest.push(respTest);

	respTest = it('Existe la funcion "GUARDAR ASIGNACION"', function(done) {
		//console.log('Validamos que exista la funcion de "Guardar Asignacion"');
		expect(typeof SalesUp.Variables.accionesComunes.guardarAsignacion).toEqual('function');
		done();
	});

	arrTest.push(respTest);

	respTest = it('Validamos los datos del prospecto', function(done) {
		//console.log('validamos los datos del prospecto');
		setTimeout(function() {
			var $popup = $('#frmAsignar');
			var tkp = $popup.find('#tkp').val();	//Recuperamos el tkp del popup y comparamos con el resultado original
			expect(SalesUp.Variables.Tkp).toEqual(tkp);
			done();
		}, 3000);
	});

	arrTest.push(respTest);

	respTest = it('Validamos que exista una lista de ejecutivos y seleccionamos alguno', function(done) {
		//console.log('Validamos que exista una lista de ejecutivos');
		var $select = $('#idusuario');
		var selectize = $select[0].selectize;
		//selectize.refreshOptions();
		expect(true).toBeTruthy();

		var data = SalesUp.Variables.jsonUsuarios.jsonDatos;
		for(var i in data){
			if(typeof selectize.options[data[i].IDUSUARIO] == 'object' && data[i].IDUSUARIO != SalesUp.Variables.ejecutivoOriginal){
				expect(typeof selectize.options[data[i].IDUSUARIO]).toEqual('object');	
				selectize.addItem(data[i].IDUSUARIO);
				SalesUp.Variables.ejecutivoNuevo = data[i].IDUSUARIO;
				console.log('IdNuevo: ' + SalesUp.Variables.ejecutivoNuevo);
				done();
			}
		}
		done();		
	});

	arrTest.push(respTest);
	
	respTest = it('creamos comentario', function(done) {
		setTimeout(function(){
			$('#comentario').val('Comentario de prueba');
			if($('#conservarContainer').text != ''){
				$('#reasignar_oportunidad').prop('checked', true);
			}
			expect($('#reasignar_oportunidad').prop('checked')).toBeTruthy();
			done();
		}, 1000)
	});

	arrTest.push(respTest);

	respTest = it('Validamos que se guarde correctamente la reasignacion', function(done) {
		setTimeout(function () {
			var template = (SalesUp.Variables.origen == 'prospectos') ? 'popup_asignar_prospecto' : 'popup_asignar_oportunidad';
			SalesUp.Variables.accionesComunes.guardarAsignacion({template: template});

			setTimeout(function() {
				//console.log('Validamos que se guarde correctamente el ejecutivo');
				var dataJson = SalesUp.Variables.jsonprospectos || SalesUp.Variables.jsonoportunidad;
				expect(dataJson.JsonDatos[0].IdUsuario).toEqual(SalesUp.Variables.ejecutivoNuevo);
				done();
			}, 3000);
		}, 1000);
	});

	arrTest.push(respTest);


	afterAll(function(done) {
		//console.log('Regresamos al ejecutivo original');
		SalesUp.Variables.accionesComunes.reasignar({Tkp: SalesUp.Variables.Tkp, Tko: SalesUp.Variables.Tko, titulo: 'Reasignar el prospecto a otro ejecutivo', callback: ReloadData});

		setTimeout(function() {
			var $select = $('#idusuario');
			var selectize = $select[0].selectize;

			selectize.addItem(SalesUp.Variables.ejecutivoOriginal);
			var template = (SalesUp.Variables.origen == 'prospectos') ? 'popup_asignar_prospecto' : 'popup_asignar_oportunidad';
			SalesUp.Variables.accionesComunes.guardarAsignacion({template: template});

			setTimeout(function() {
				//console.log('Validamos que se guarde correctamente el ejecutivo original');
				var dataJson = SalesUp.Variables.jsonprospectos || SalesUp.Variables.jsonoportunidad;
				expect(dataJson.JsonDatos[0].IdUsuario).toEqual(SalesUp.Variables.ejecutivoOriginal);
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