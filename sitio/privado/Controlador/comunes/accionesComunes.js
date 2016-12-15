var accionesComunes = function() {

	this.reasignar = function(Parametros){
		var tipo;
		var params = {};
		params.tkp = Parametros.Tkp;
		params.tkcom = Parametros.TkCom;
		SalesUp.Variables.reasignarCallback = Parametros.callback;

		//configuracion de los parametros para los formularios y para las llamadas por AJAX
		if(Parametros.seccion == 'prospecto'){
			tipo = Parametros.origen == 4 ? 'el cliente' : 'el prospecto';
			Parametros.template = 'prospecto';
			params.usuarioprospecto = $('#idUsuario').val();
		} else {
			tipo = Parametros.origen == 4 ? 'el cliente' : 'la oportunidad';
			Parametros.template = 'oportunidad';
		}

		//Obtenemos la informacion de oportunidades
		SalesUp.Sistema.CargaDatosAsync({
			link: '/privado/Modelo/jsonTieneOportunidad.dbsp',
			parametros: params,
			callback: function(result) {
				
				SalesUp.Construye.MuestraPopUp({
					alto:'270px', ancho:'470px', centrado:false, id:'popReasignarContacto',
					titulo: Parametros.titulo,
					fuente:'/privado/popup_asignar_' + Parametros.template + '_modal.dbsp'
				});
			
				var data = result.jsonDatos[0];

				SalesUp.Variables.tieneOportunidad = data.tieneOportunidad;
				SalesUp.Variables.conservarOportunidad = data.conservarOportunidad;
				SalesUp.Variables.sNivel = data.nivel;
			
				setTimeout(function(){
					var $popUp = $('#popReasignarContacto');
					$popUp.find('#tipo').append(tipo);
					$popUp.find('#tkp').val(Parametros.Tkp);
					$popUp.find('#TkCom').val(Parametros.TkCom);
					$popUp.find('#tko').val(Parametros.Tko);
					$popUp.find('#sNivel').val(SalesUp.Variables.sNivel);
					$popUp.find('#tieneOportunidad').val(SalesUp.Variables.tieneOportunidad);

					//validamos nivel y si se tienen que conservar las oportunidades
					if(Parametros.seccion == 'prospecto'){
						if( (SalesUp.Variables.sNivel == 3 && SalesUp.Variables.conservarOportunidad > 0) || SalesUp.Variables.conservarOportunidad > 0){
							$('#conservarContainer').append('<label style="background: transparent none repeat scroll 0% 0%; font-style: italic;"><input id="conservar_oportunidades" class="laseleccion" type="checkbox" name="conservar_oportunidades" value="1"> Conservar oportunidades</label>');
						}
					} else {
						//oportunidad
						$('#conservarContainer').append('<label style="background: transparent none repeat scroll 0% 0%; font-style: italic;"><input id="reasignar_oportunidad" class="laseleccion" type="checkbox" name="reasignar_oportunidad" value="1"> Compartir pero conservar la propiedad</label>');	
					}

					 
				}, 200);

				LtUsuariosGruposAutorizados(Parametros);			
					
			}
		});
	}

	this.guardarAsignacion = function(Parametros) {
		var dato = $('#idusuario').val();
		var callback = SalesUp.Variables.reasignarCallback;
	  	if(dato == '') {
	    	SalesUp.Construye.MuestraMsj({tMsg:4, Destino:'#frmAsignar', Msg:'Debe seleccionar un <strong>ejecutivo</strong>' });
	  	} else {
	  		$('#frmAsignar').find('#BtnAceptar').attr('disabled','disabled')
	  		var formData = $('#frmAsignar').serialize();
	  		SalesUp.Sistema.CargaDatosAsync({
	  			link: Parametros.template + '_agregar.dbsp', 
	  			parametros: formData, 
	  			callback: function(){
	  				SalesUp.Construye.CierraPopUp({t: '#BtnCancelar'});
	  				ReloadData();
	  				//location.reload();
	  				callback();
	  			}
	  		});
	  	}
	};

	var LtUsuariosGruposAutorizados = function(Parametros){
		var idpros = $('#idusuario').val();
		var tkp = Parametros.Tkp;
		var tko = Parametros.Tko;
		var sGrupo = '<#SESSION.IDGRUPO/>';
		var jsonFile = Parametros.jsonFile || '';

		SalesUp.Sistema.CargaDatosAsync({
			link: '/privado/Modelo/jsonListarUsuarios' + jsonFile + '.dbsp',
			almacen: 'jsonListaUsuarios' + jsonFile,
			callback: function(result) {
				SalesUp.Variables.jsonUsuarios = result;

				SalesUp.Sistema.CargaDatosAsync({
					link: '/privado/Modelo/jsonMuestraUsuarios.dbsp',
					parametros: {idprospecto: idpros, tkp: tkp, idoportunidad: tko, tipo: 0},
					callback: function(res) {

						var data = res.jsonDatos;
						var idUsuario = data[0].IDUSUARIO;

						jsonUsuarios = _.reject(SalesUp.Variables.jsonUsuarios.jsonDatos, function(j){  
					  		if(j.IDUSUARIO == idUsuario){
							    return j;
					  		}
						});

						var arrGrupos = [];
						var arrIdGrupos = [];
						var objGrupos = [];

						for(var i = 0; i <= jsonUsuarios.length - 1; i++){
					  		var GRUPO = jsonUsuarios[i].GRUPO;
					  		var IDGRUPO = jsonUsuarios[i].IDGRUPO;
					  		var arr={};
					  		
					  		if(arrGrupos.indexOf(GRUPO)==-1){
					    		arr.GRUPO = GRUPO;
					    		objGrupos.push(arr);
					    		arrGrupos.push(GRUPO);
					    		arrIdGrupos.push(IDGRUPO);
					  		}
						}

						var Posicion = '';
						for(var x = 0; x <= arrIdGrupos.length - 1; x++){
					  		if(arrIdGrupos[x]==sGrupo){Posicion=x;}
						}

						var MiGrupo = arrGrupos[Posicion];

						arrGrupos = _.reject(arrGrupos, function(arr){ 
					  		if(arr==MiGrupo)
					  			return arr; 
						});

						var arrNuevoOrden = [];
						arrNuevoOrden.push(MiGrupo);

						arrGrupos = _.sortBy(arrGrupos, function(arr){ 
					  		return arr; 
						});

						for(var z = 0; z <= arrGrupos.length - 1; z++){
					  		arrNuevoOrden.push(arrGrupos[z]);
						}
					
						setTimeout(function(){
							$('#idusuario').selectize({
								maxItems:1,plugins: ['optgroup_columns'],
						    	options:jsonUsuarios,
						    	valueField:'IDUSUARIO',
						    	searchField:['NOMBRE'],
						    	labelField:'NOMBRE',
						    	optgroups:objGrupos,
						    	optgroupField:'GRUPO',
						    	optgroupLabelField:'GRUPO',
						    	optgroupValueField:'GRUPO',
						    	optgroupOrder:arrNuevoOrden,
							});
						}, 10);
					}
				});
			}

		});
	} /* /SalesUp.Variables.LtUsuario */

	this.etiquetar = function(Parametros) {
		var iduser = $('#idUsuario').val();
		SalesUp.Variables.etiquetarCallback = Parametros.callback;
		//Cargamos todas las etiquetas
		SalesUp.Sistema.CargaDatosAsync({
			link: '/privado/Modelo/jsonLtEtiquetas.dbsp',
			almacen: 'jsonListaEtiquetas',
			callback: function(result) {
				SalesUp.Variables.etiquetas = result.jsonDatos;
			}
		});

		SalesUp.Sistema.CargaDatosAsync({
			link: '/privado/Modelo/jsonDatosProspecto.dbsp',
			parametros: {usuarioprospecto: iduser, tkp: Parametros.Tkp, tko: Parametros.Tko},
			callback: function(result) {

				SalesUp.Construye.MuestraPopUp({
					alto:'220px', ancho:'500px', centrado:false, id:'popEtiquetarContacto',
					titulo: 'Etiquetar prospecto como parte de un segmento',
					fuente:'/privado/popup_etiqueta_prospectos_modal.dbsp'
				});

				var data = result.jsonDatos[0];

				SalesUp.Variables.idprospecto = data.IDPROSPECTO;
				SalesUp.Variables.nombreProspecto = data.Nombre + ' ' + (data.Apellidos || '');
				SalesUp.Variables.empresa = data.Empresa;
				SalesUp.Variables.etiquetasUsuario = data.Etiquetas;

				setTimeout(function(){
					var $popUp = $('#popEtiquetarContacto');
					$popUp.find('#tkp').val(Parametros.Tkp);
					$popUp.find('#TkCom').val(Parametros.TkCom);
					$popUp.find('#idprospecto').val(SalesUp.Variables.idprospecto);
					$popUp.find('#username').append(SalesUp.Variables.nombreProspecto);
					$popUp.find('#etiquetasiniciales').val(SalesUp.Variables.etiquetasUsuario);

					if(SalesUp.Variables.empresa != null && SalesUp.Variables.empresa != undefined){
						$popUp.find('.tabla1').append('<tr><th width="80">Empresa</th><td id="empresa">' + SalesUp.Variables.empresa +'</td></tr>');
					}

					var $select = $popUp.find('#etiquetas').selectize({
						create: false,
						sortField: 'text',
						valueField: 'IdEtiqueta',
						options: SalesUp.Variables.etiquetas,
						items: SalesUp.Variables.etiquetasUsuario.split(','),
						maxItems: null,
						dropdownParent: 'body',
						plugins: ['remove_button']
					});

					$popUp.find('.selectize-control.ltEtiquetas').addClass('w100 BoxSizing InfoData');
				}, 200);
			}
		});
	};

	this.guardarEtiquetas = function(Parametros) {
		//Agregamos las nuevas etiquetas
		var callback = SalesUp.Variables.etiquetarCallback;
		var $popUp = $('#popEtiquetarContacto');
		$popUp.find('#nuevasEtiquetas').val($popUp.find('#etiquetas').val());
		var formData = $('#frmEtiquetas').serialize();

		SalesUp.Sistema.CargaDatosAsync({
			link: '/privado/popup_etiqueta_prospectos_guarda.dbsp',
			parametros: formData,
			//callback: recargarTablaContactos
			callback: function(){
				SalesUp.Construye.CierraPopUp({t: '#BtnCancelar'});
  				//ReloadData();
  				//location.reload();
  				callback();
			}
		});
	};
}


$(function() {
	SalesUp.Variables.accionesComunes = new accionesComunes();
});