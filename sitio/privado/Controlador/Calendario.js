SalesUp.Sistema.ColoresTema();

var FormatoDeLaFecha = SalesUp.Sistema.Almacenamiento({a:'SysFormatoFecha'});
FormatoDeLaFecha = SalesUp.Sistema.StrReplace('yy','yyyy',FormatoDeLaFecha);
FormatoDeLaFecha = FormatoDeLaFecha.toUpperCase();
var AplicarConfiguracion=true;

$Calendario = $('#Calendario');

SalesUp.Variables.MiCalendario = function(Op){
  SalesUp.Variables.ConfiguracionVista=(SalesUp.Variables.ConfiguracionVista==undefined || SalesUp.Variables.ConfiguracionVista==null)?'agendaDay':SalesUp.Variables.ConfiguracionVista;
  var DivCalendario, Eventos = '' , citas = '', tareas = '', recordatorios = '', jsonEventos={};
  
  (!Op) ? Op = {} : '';
  
  (!_.isUndefined(Op.eventos)) ? jsonEventos = Op.eventos : '';
  
  jsonEventos = _.reject(jsonEventos , function(d){ return _.size(d) == 0; });
  
  EventoAhora = {};
  EventoAhora.color = '#FF0000';
  EventoAhora.id = 'Ahora';
  EventoAhora.title = '';
  EventoAhora.start = moment().format('YYYY-MM-DD HH:mm');
  EventoAhora.end = moment().add(1,'m').format('YYYY-MM-DD HH:mm');
  EventoAhora.className = 'EventoAhora';
  jsonEventos = _.union(jsonEventos,EventoAhora);
    $Calendario.fullCalendar('destroy');
    $Calendario.fullCalendar({
      header:{ left:'prev,next today month,agendaWeek,agendaDay', center:'title', right:'' },
      defaultView: SalesUp.Variables.ConfiguracionVista , weekMode: 'liquid', contentHeight: 500, lang: 'es', timeFormat: { agenda: 'H(:mm)', '': 'H(:mm)' } , axisFormat: 'H(:mm)',
      editable: true, eventDurationEditable:false, dragOpacity:{agenda: 1.0,'':1.0},
      buttonIcons:{ prev: '', next: '' }, defaultTimedEventDuration:'01:00:00',
      events: jsonEventos,
      eventMouseover:function( event, jsEvent, view ){
        SalesUp.Variables.ActivarPopOver({Elemento:jsEvent.currentTarget, Evento:event});
      },eventMouseout:function( event, jsEvent, view ){
        /*var $Elemento = $(jsEvent.currentTarget); */
        /*$Elemento.popover('destroy');*/
      },eventClick:function(calEvent, jsEvent, view){
        SalesUp.Variables.AlertaEvento({Elemento:jsEvent.currentTarget, Evento:calEvent});
      },eventRender:function( event, element, view ){
        var iconoEvento = '<i class="fa fa-bell"></i>';
        (event.Tipo==1) ? iconoEvento = '<i class="fa fa-bell"></i>' : '';
        (event.Tipo==2) ? iconoEvento = '<i class="fa fa-calendar"></i>' : '';
        (event.Tipo==3) ? iconoEvento = '<i class="fa fa-share-square"></i>' : '';
        var $Elemento = $(element);
        $Elemento.find('.fc-event-title').addClass('Html');
        $Elemento.find('.fc-event-inner').addClass('Html');
        var hora = $Elemento.find('.fc-event-time').html();
        hora = iconoEvento+'<span class="FormatoHora">'+hora+'</span>';
        $Elemento.find('.fc-event-time').html(hora);


        var classes=$Elemento.attr('class'); 
        var c=classes.split(' '); 
        for(var a=0; a<=c.length-1; a++){ 
          if(c[a].indexOf('IDC')!=-1){ 
            $Elemento.attr('data-idcita', c[a]);
          } 
        }   

        
      }, eventAfterAllRender: function(view){ 
        SalesUp.Sistema.FormatoHora();
        SalesUp.Sistema.InterpretaHtml();
        DivCalendario = '#VistaCombinada';
        ($('#VistaCalendario').is(':visible')) ? DivCalendario = '#VistaCalendario':'';
        if($(DivCalendario+' .ActivaCitas').attr('data-Citas') == 0){ $(DivCalendario+' .EventoCita').hide(); }
        if($(DivCalendario+' .ActivaTareas').attr('data-Tareas') == 0){ $(DivCalendario+' .EventoTareas').hide(); }
        if($(DivCalendario+' .ActivaRecordatorios').attr('data-Recordatorios') == 0){ $(DivCalendario+' .EventoRecordatorio').hide(); }
        if($(DivCalendario+' .ActivaTareasAsignadas').attr('data-TareasAsignadas') == 0){ $(DivCalendario+' .EventoTareasAsignadas').hide(); }
        var hr = moment().hour();
        var scroll = (hr-3)*40;
        var slot = '.fc-slot'+(hr*2);
        setTimeout(function() {
          $(DivCalendario+' .fc-view > div > div:last-child').scrollTop(scroll);
          // $(slot).children().addClass('HoraActual');
          if(_.size($('.fc-today'))){
            var left = Math.ceil($('.fc-today').position().left);
            var width = $('.fc-today').width();
            $('.EventoAhora').css('left',left).css('width',width);  
          }
        }, 500);
        SalesUp.Variables.EjecutarCambios();
        SalesUp.Variables.leerConfiguracionesCalendario();
        eliminaCitasDobles();
      },
      viewRender:function(view, element){
        var getView = $Calendario.fullCalendar('getView');
        var fInicio = moment(getView.intervalStart).format('YYYY-MM-DD HH:mm:ss');
        var fFin =  moment(getView.intervalEnd).format('YYYY-MM-DD HH:mm:ss');
        var fInicioUnix = moment(fInicio).unix();
        var fFinUnix = moment(fFin).unix()-1;

        SalesUp.Variables.RangoInicio = moment(getView.intervalStart).format('DD/MM/YYYY');
        SalesUp.Variables.RangoFin = moment(getView.intervalEnd).format('DD/MM/YYYY');

        var EventosVista =  _.reject(jsonEventos, function(j){  
          var fecha = j.start;
          var fUnix = moment(fecha).unix();
          if(!((fUnix>=fInicioUnix)&&(fUnix<fFinUnix))){ return j; }
        });

        EventosVista =  _.reject(EventosVista, function(j){  
          if(j.id=='Ahora'){ return j; }
        });        

        EventosVista = _.sortBy(EventosVista , function(j){ return j.DTF; });

        SalesUp.Variables.TablaTareasRecordatorios({Eventos:EventosVista});
        
        SalesUp.Sistema.OcultaEspera();        
      }, selectable:true, selectHelper: true,
      select:function( start, end, jsEvent, view ){
        $('.popover').remove();
        var ds = parseInt(moment(start).format('DD'));
        var de = parseInt(moment(end).format('DD'));
        if(de>ds){de = de-1;}
        
        if(ds!=de){$Calendario.fullCalendar('unselect'); return false;}
        if(moment(start).get('hour')==0){$Calendario.fullCalendar('unselect'); return false;}

        var view = $Calendario.fullCalendar('getView');
        var Vista = view.name;
        
        SalesUp.Variables.DatosNuevoEvento = '';
        var Datos = '';
        Datos += 'Vista='+Vista;
        Datos += '&fInicio='+moment(start).format(FormatoDeLaFecha);
        Datos += '&fFin='+moment(end).format(FormatoDeLaFecha);
        Datos += '&hInicio='+((moment(start).get('hour')>9)?moment(start).get('hour'):'0'+moment(start).get('hour'))+':'+((moment(start).get('minute')!='0')?moment(start).get('minute'):'0'+moment(start).get('minute'));
        Datos += '&hFin='+((moment(end).get('hour')>9)?moment(end).get('hour'):'0'+moment(end).get('hour'))+':'+((moment(end).get('minute')!='0')?moment(end).get('minute'):'0'+moment(end).get('minute'));
        var Usr = '';
        var Usr2 = '';
        if(SalesUp.Variables.SessionIdUsuario != SalesUp.Variables.IdUsuario){
          $.each(SalesUp.Variables.IdUsuario.split(','),function(i,v){
            if(SalesUp.Variables.SessionIdUsuario != v){
              Usr += 'U'+v+',';
              Usr2 += v+',';
            }
          })
          Datos += '&idu='+Usr;
          Datos += '&idusr='+Usr2;
        }
        
        Datos += '&idusuarioActuales='+SalesUp.Variables.IdUsuario;
        SalesUp.Variables.DatosNuevoEvento = Datos;
        
        var PopOverId = SalesUp.Construye.IdUnico();
        var TemplatePopover = '<div class="popover PopOverAcciones PopOverNuevoEvento" id="'+PopOverId+'" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>';
        var QueHacer = '';
        QueHacer += '<span class="OpcionAcciones Pointer" onclick="SalesUp.Variables.NuevoEvento({Tipo:1});"><i class="fa fa-lg fa-bell"></i> Nuevo recordatorio</span>';
        QueHacer += '<span class="OpcionAcciones Pointer" onclick="SalesUp.Variables.NuevoEvento({Tipo:2});"><i class="fa fa-lg fa-share-square"></i> Nueva tarea</span>';
        QueHacer += '<span class="OpcionAcciones Pointer" onclick="SalesUp.Variables.NuevoEvento({Tipo:3});"><i class="fa fa-lg fa-calendar"></i> Nueva cita</span><div class="clear"></div>';

        var $Elemento = $(jsEvent.target);
        $Elemento.popover('destroy');
        $Elemento.popover({ template:TemplatePopover, placement:'bottom', html:true, container:'body', title:'', content:QueHacer });            
        $Elemento.popover('show');
        
        var $PopOverId = $('#'+PopOverId);
        var Cerrar = true;
        $PopOverId.mouseleave(function(){ Cerrar = true; setTimeout(function(){$Calendario.fullCalendar('unselect'); (Cerrar) ? $PopOverId.hide():'';}, 500);})
        .mouseenter(function(){ Cerrar = false;})
        .click(function(){ $PopOverId.hide(); $Calendario.fullCalendar('unselect'); });

        setTimeout(function(){ if(Cerrar){ $Calendario.fullCalendar('unselect'); $PopOverId.hide(); } }, 3000);
        
      },eventDrop: function(event, delta, revertFunc, jsEvent, ui, view ){
        $('.popover').remove();
        var FechaFin, HoraFin;
        var DetalleEvento = event;
        var fInicial = DetalleEvento.start;
        var fFinal = DetalleEvento.end;
        var TipoEvento = DetalleEvento.Tipo;
        var IdEvento = SalesUp.Sistema.SoloNumero(DetalleEvento.id);
        var Idu = DetalleEvento.Idu;
        var DuenioRecordatorio = DetalleEvento.Duenio;
        var Tiempo = delta;
        var Dias = Tiempo.days();
        var Horas = Tiempo.hours();
        var Minutos = Tiempo.minutes();
        
        var EditarFechaTarea = (((DetalleEvento.Editar)||(DetalleEvento.TareaAsiganda)) ? 1 : 0);
        
        if(!TipoEvento){ revertFunc(); return false; }

        if((TipoEvento==4)&&(TipoEvento==5)){
          revertFunc(); return false;
        }
        
        if((TipoEvento==1)&&(DuenioRecordatorio=='')){
          revertFunc(); return false;
        }

        var Datos = 'id='+IdEvento+'&TipoEvento='+TipoEvento+'&EditarFechaTarea='+EditarFechaTarea+'&Dias='+Dias+'&Horas='+Horas+'&Minutos='+Minutos; 
        
        SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryActualizaFechaEvento.dbsp', Parametros:Datos});
        
        if(TipoEvento==2){
          FechaFin = moment(fFinal).format(FormatoDeLaFecha);
          HoraFin = moment(fFinal).format('HH:mm');  
        }else{
          FechaFin = moment(fInicial).format(FormatoDeLaFecha);
          HoraFin = moment(fInicial).format('HH:mm');  
        }
        
        if((TipoEvento==3)&&(EditarFechaTarea==0)){
          SalesUp.Construye.MuestraAlerta({
            TipoAlerta:'AlertaModal', Ancho:'350px', Id:'ModalModificarFechaTarea',
            Alerta: '<h2>La solicitud de cambio de fecha de vencimiento se ha enviado.</h2>', Titulo:'Cambio de fecha de vencimiento',
            BotonOk:'Cerrar', IconoOk:'<i class="fa fa-times"></i>'
          });
          revertFunc();
          $('#TableTareasRecordatorios tbody tr.ID'+DetalleEvento.id).find('td').eq('6').html('M�s tiempo');
          return false;
        }

        $('#TableTareasRecordatorios tbody tr.ID'+DetalleEvento.id).find('td').eq('2').html(SalesUp.Sistema.StrReplace('.','',FechaFin));
        $('#TableTareasRecordatorios tbody tr.ID'+DetalleEvento.id).find('td').eq('3').html(HoraFin);

        var RecordatororioActivo = (!moment().isAfter(moment(fInicial)));
        if((TipoEvento==1)&&(RecordatororioActivo)){
          $('#TableTareasRecordatorios tbody tr.ID'+DetalleEvento.id).find('td').eq('6').html('Activo');
          $('#TableTareasRecordatorios tbody tr.ID'+DetalleEvento.id).find('td').eq('5').removeClass('EventoVencido');
        }
      },eventDragStop:function( event, jsEvent, ui, view ){
        
      },eventDragStart : function(event, jsEvent, ui, view){

      }
    });/*  /fullcalendar */
      
    $('.fc-button-prev').attr('onclick','SalesUp.Variables.CambiarMes({});').html('<i class="fa fa-lg fa-angle-double-left"></i>');
    $('.fc-button-next').attr('onclick','SalesUp.Variables.CambiarMes({});').html('<i class="fa fa-lg fa-angle-double-right"></i>');
    $('.fc-button-prev').html('<i class="fa fa-lg fa-angle-double-left"></i>');
    $('.fc-button-next').html('<i class="fa fa-lg fa-angle-double-right"></i>');
    $('.fc-button-today').attr('onclick','SalesUp.Variables.CambiarMes({vista:'+"'agendaDay'"+'});');

    var btnCalendario = '';
    btnCalendario = btnCalendario + '<span class="fc-header-space"></span>';
    btnCalendario = btnCalendario + '<span id="PickerCalendario" class="fc-button fc-state-default fc-corner-right fc-corner-left" > ';
    btnCalendario = btnCalendario + '<i class="Pointer fa fa-lg fa-calendar"></i>';
    btnCalendario = btnCalendario + '<input type="text" class="Pointer" id="CalendarioPicker" onchange="SalesUp.Variables.CambiarFechaCalendario({fecha:value, vista:'+"'agendaDay'"+'})" />';
    btnCalendario = btnCalendario + '</span>';

    $('.fc-header-left').append(btnCalendario);
    var MasVistas = '';
    MasVistas = MasVistas + '<span id="BoxMasListas">';
    MasVistas = MasVistas + '<span data-toggle="dropdown" id="MasVistas" class="dropdown-toggle fc-button fc-state-default fc-corner-right fc-corner-left">';
    MasVistas = MasVistas + ' <i id="Ellipsis1" class="fa fa-lg fa-ellipsis-v"></i>';
    MasVistas = MasVistas + ' <i id="Ellipsis2" class="fa fa-lg fa-ellipsis-v"></i>';
    MasVistas = MasVistas + ' <i id="Ellipsis3" class="fa fa-lg fa-ellipsis-v"></i>';
    MasVistas = MasVistas + '</span>';
    MasVistas = MasVistas + '<ul class="dropdown-menu">';
    MasVistas = MasVistas + '<li><a href="#">Vista combinada <i class="fa fa-check Verde"></i></a></li>';
    MasVistas = MasVistas + '<li><a href="#">Vista calendario</a></li>';
    MasVistas = MasVistas + '<li><a href="#">Vista de pendientes</a></li>';
    MasVistas = MasVistas + '</ul>';
    MasVistas = MasVistas + '</span>';
    MasVistas = MasVistas + '';
    //$('.fc-header-right').append(MasVistas);
    $('#CalendarioPicker').datepicker(ConfiguracionPicker);
    ($('#VistaCalendario').is(':visible')) ? $('#VistaCalendario #PickerCalendario').remove() : '';
    setTimeout(function(){
      $('.CargandoCalendario').fadeOut();
    }, 200);
    // setTimeout(function(){$('.CargandoCalendario').remove();}, 1000);

} /* MiCalendario */


SalesUp.Variables.AlertaEvento = function(Op){
  
  var $Elemento = $(Op.Elemento);
  var Eventos = Op.Evento;
  var Titulo = '';
  var TipoEvento = Eventos.Tipo;
  
  Titulo = Eventos.title;
  
  $Elemento.popover('destroy');
  
  if(TipoEvento==1){
    var Idr = SalesUp.Sistema.SoloNumero(Eventos.id);
    if(Eventos.Duenio!='1'){return false;}
    SalesUp.Sistema.AbrePopUp({
      Titulo: 'Editar recordatorio',
      Pagina: 'popup_editar_recordatorio.dbsp',
      Parametros:'propio=1&idrecordatorio='+Idr,
      CallBack:'SalesUp.Variables.RecargarDatos',
      Modal:true, ModalAlt:true, Alto:200, Ancho:600
    });
    
  }

  if(TipoEvento==2){
    SalesUp.Variables.TemplateEventoCalendario = SalesUp.Sistema.CargaDatos({Link:'/privado/Vista/TemplateEventoCalendario.dbsp', Almacen:'HtmlEventoCalendario'});
    /*SalesUp.Variables.TemplateEventoCalendario = SalesUp.Sistema.CargaDatos({Link:'/privado/Vista/TemplateEventoCalendario.dbsp'});*/
    
    SalesUp.Variables.IdEventoActual = SalesUp.Sistema.SoloNumero(Eventos.id);
    
    Eventos.tCita = '1';
    
    var HtmlEvento = SalesUp.Construye.ReemplazaDatos({ Template: SalesUp.Variables.TemplateEventoCalendario, Datos: Eventos });

    SalesUp.Construye.MuestraAlerta({
      TipoAlerta:'AlertaModal', Ancho:'650px', Id:'ModalEventos',
      Alerta: HtmlEvento, Titulo: Titulo,
      BotonOk:'Cerrar', IconoOk:'<i class="fa fa-times"></i>',
      IdBoton1:'BtnCerrarEvento'
    });                                     //onclick="SalesUp.Variables.ConfirmarEliminarCita({ Elemento:this, Idu:'+Eventos.Idu+' });
                                            //onclick="SalesUp.Variables.PopUpEliminarEvento({id:'+"'"+IdTarea+"'"+', Tipo:'+"'"+2+"'"+' });"
    $('#ModalEventos .PieModal').append('<a onclick="SalesUp.Variables.ConfirmarEliminarCita({ Elemento:this, Idu:'+Eventos.Idu+' });" class="Left Pointer Btn Btn-rounded Btn-small Btn-flat-Cancelar Html"><i class="fa fa-trash-o"></i> Eliminar</a>');
    $('#ModalEventos .PieModal').append('<a onclick="SalesUp.Construye.CierraAlerta({ Elemento:this, Callback:'+"SalesUp.Variables.EditarCita"+' });" class="Left Pointer Btn Btn-rounded Btn-small Btn-flat-Cancelar Html"><i class="fa fa-edit"></i> Editar</a>');  
    if(Eventos.ConProspecto){
      $('#BtnCerrarEvento').html('<i class="fa fa-save"></i> Guardar').attr('onclick','SalesUp.Variables.GuardarComentarioEvento({Elemento:this});');
    }

    setTimeout(function(){ $('#ComentarioEvento').focus(); }, 500);

    $('#TituloModal').addClass('Html');
    SalesUp.Sistema.InterpretaHtml();
  } /* / TipoEvento == 2 */


  if(TipoEvento==3){
    document.location.href = 'VerTarea.dbsp?tk='+Eventos.Tk;
  }

  if((TipoEvento==4)||(TipoEvento==5)){
    document.location.href = '/privado/ventas-visualizar.dbsp?idoportunidad='+Eventos.ido+'&IDVENTA='+Eventos.Idv;
  }

} /* /SalesUp.Variables.AlertaEvento */

SalesUp.Variables.GuardarComentarioEvento = function(Op){
  var Pasa = SalesUp.Valida.ValidaObligatorios({DentroDe:'#ModalEventos ', DestinoMsj:'#ModalEventos .BodyModal'});
  if(!Pasa){return false;}

  var DatosCita = 'idc='+SalesUp.Variables.IdEventoActual+'&comentario='+escape($('#ComentarioEvento').val());
  SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryGuardarComentarioCita.dbsp', Parametros:DatosCita });

  SalesUp.Construye.CierraAlerta({Elemento:Op.Elemento});

}/*SalesUp.Variables.GuardarComentarioEvento*/

SalesUp.Variables.ConfirmarEliminarCita = function(Op){
  SalesUp.Construye.MuestraAlerta({
    TipoAlerta:'AlertaPregunta', Ancho:'350px', Id:'EliminarCita',
    Alerta: '�Est� seguro de eliminar esta cita del calendario?', 
    Boton1:'Eliminar', Icono1:'<i class="fa fa-trash-o"></i>', Callback1:'SalesUp.Variables.EliminarCita({Idu:'+Op.Idu+'})',
    Boton2:'Cancelar', Icono2:'<i class="fa fa-times"></i>'
  });
  /**/
}

SalesUp.Variables.EliminarCita = function(Op){

  var DatosCita = 'idc='+SalesUp.Variables.IdEventoActual+'&idu='+Op.Idu;
  SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryEliminarCita.dbsp', Parametros:DatosCita });
  SalesUp.Construye.CierraAlerta({Elemento:$('#BtnCerrarEvento')});
  
  var $CitaActual, $RowCitaActual;

  if ($('#VistaCombinada').is(':visible')){
    $CitaActual = $('#Calendario .EventoCita.IDC'+SalesUp.Variables.IdEventoActual);
    $RowCitaActual = $('#TableTareasRecordatorios .EventoCita.IDC'+SalesUp.Variables.IdEventoActual);
  }

  if ($('#VistaCalendario').is(':visible')){
    $CitaActual = $('#CalendarioPorUsuario .EventoCita.IDC'+SalesUp.Variables.IdEventoActual);
  }

  if($('#VistaTareasRecordatorios').is(':visible')){
    $RowCitaActual = $('#TablaTareasRecordatorios .EventoCita.IDC'+SalesUp.Variables.IdEventoActual);
  }

  setTimeout(function(){
    ($CitaActual) ? $CitaActual.addClass('BounceCloseOut'):'';
    ($RowCitaActual) ? $RowCitaActual.css('background','#dc0f24').css('color','#fff').hide('slow'):'';
    setTimeout(function(){ 
      ($CitaActual) ? $CitaActual.remove():''; 
      ($RowCitaActual) ? $RowCitaActual.remove():''; 
    }, 1000);
  }, 800);



}/*SalesUp.Variables.EliminarCita*/

SalesUp.Variables.EditarCita = function(){
  var id = SalesUp.Sistema.StrReplace('C','',SalesUp.Variables.IdEventoActual);
  SalesUp.Ventana.EditarCita({Id:id});
}


SalesUp.Variables.ActivarPopOver = function(Op){
  //console.info(Op);
  (Op.Tipo)?Op.Tipo:'';
  var Contenido = '', Titulo = '';
  var $Elemento = $(Op.Elemento);
  var Eventos = Op.Evento;
  var TipoEvento = Eventos.Tipo;
  $('.popover').hide();
  $Elemento.popover('destroy');

  var DireccionPopOver = 'top';
  (Op.PopOverLugar) ? DireccionPopOver = Op.PopOverLugar : '';

  if(TipoEvento==0){
    Titulo = Eventos.title;
    Contenido += '<i class="fa fa-2x fa-bell"></i><i class="fa fa-share-square fa-2x"></i><i class="fa fa-2x fa-calendar"></i>';
  }

  var DatoProspecto ='';
  var DatoEmpresa ='';
  var UrlLink = '';
  if(Eventos.IdProspecto){
    if(Eventos.IdOportunidad){
        if(Eventos.Tkv){
          UrlLink = '/privado/ventas-visualizar.dbsp?tko='+Eventos.Tko+'&tkv='+Eventos.Tkv+'&IdOportunidad='+Eventos.IdOportunidad+'&IdVenta='+Eventos.IdVenta;
        }else{
          UrlLink = '/privado/oportunidades-visualizar.dbsp?tko='+Eventos.Tko+'&idoportunidad='+Eventos.IdOportunidad;
        }
      }else{
        if(Eventos.EsCliente){
          UrlLink = '/privado/clientes-visualizar.dbsp?tkp='+Eventos.Tkp+'&idprospecto='+Eventos.IdProspecto;
        }else{
          if(Eventos.Tkv){
            UrlLink = '/privado/ventas-visualizar.dbsp?tko='+Eventos.Tko+'&tkv='+Eventos.Tkv+'&IdOportunidad='+Eventos.IdOportunidad+'&IdVenta='+Eventos.IdVenta;
          }else{
            UrlLink = '/privado/prospectos-visualizar.dbsp?tkp='+Eventos.Tkp+'&idprospecto='+Eventos.IdProspecto;
          }
        }
      }
      
      DatoProspecto += '<span class="Pointer" onclick="window.open('+"'"+UrlLink+"'"+','+"'_self'"+');">'+Eventos.Prospecto+'</span>';

      if(Eventos.Empresa){
        if(Eventos.TkCom){
          UrlLink = '/privado/EmpresasVisualizar.dbsp?tkcom='+Eventos.TkCom;
          DatoEmpresa = '<span class="Pointer" onclick="window.open('+"'"+UrlLink+"'"+','+"'_self'"+');"><i class="fa fa-building"></i> <b>'+Eventos.Empresa+'</b></span>';
        }else{
          DatoEmpresa = Eventos.Empresa;
        }     
      }
  }else{
    if(Eventos.ConProspecto){
      DatoProspecto += '<span class="ContactosCitas" data-contacto="'+Eventos.Contactos+'" data-ids="'+Eventos.IdsProspectos+'" data-tk="'+Eventos.TksProspectos+'"></span>';
    }else{
      DatoProspecto += '';
    }
  }

  if(TipoEvento==1){
    if(Eventos.Prospecto){
      Titulo = Eventos.title;
      Contenido += '<p><i class="fa fa-user"></i> '+DatoProspecto+' - <i>['+Eventos.Iniciales+']</i></p>';
      (DatoEmpresa) ? Contenido += '<p>'+DatoEmpresa+'</p>':'';
      (Eventos.Telefono) ? Contenido += '<p><i class="fa fa-phone-square"></i> '+Eventos.Telefono+'</p>':'';
      (Eventos.Telefono2) ? Contenido += '<p><i class="fa fa-phone-square"></i> '+Eventos.Telefono2+'</p>':'';
      (Eventos.Movil) ? Contenido += '<p><i class="fa fa-lg fa-mobile"></i> '+Eventos.Movil+'</p>':'';
    }else{
      Titulo = '';
      Contenido += '<p><i>['+Eventos.Iniciales+']</i> - <b>'+Eventos.title+'</b></p>';
    }
  }

  if(TipoEvento==2){
    Titulo = Eventos.title;
    (Eventos.ConProspecto)? Contenido += '<p><b>Contacto: </b><i>'+DatoProspecto+'</i></p>':'';
    (Eventos.Lugar) ? Contenido += '<p><b>Donde: </b><i>'+Eventos.Lugar+'</i></p>':'';
    if(Eventos.MismoDia){
      Contenido += '<p><b>Cuando: </b><i>'+Eventos.FechaInicio+' a las '+Eventos.HoraInicio+'</i></p>'
    }else{
      Contenido += '<p><b>Inicia: </b><i>'+Eventos.FechaInicio+' '+Eventos.HoraInicio+'</i></p>';
      Contenido += '<p><b>Termina: </b><i>'+Eventos.FechaFin+' '+Eventos.HoraFin+'</i></p>';
    }
  }

  if(TipoEvento==3){
    Titulo = Eventos.title;
    Contenido += '<p><b>Responsable: </b><i>'+Eventos.Responsable+'</i></p>';
    Contenido += '<p><b>Estado: </b><i>'+Eventos.Estado+'</i></p>';
    Contenido += '<p><b>Creado el: </b><i>'+Eventos.CreadoEl+'</i></p>';
    Contenido += ( (Eventos.Prospecto) ? '<p><b>Contacto: </b><i>'+DatoProspecto+'</i></p>' : '' );
  }

  if(TipoEvento==4){
    Titulo = Eventos.title;
    Contenido += '<p><b>Concepto: </b><i>'+Eventos.Concepto+'</i></p>';
    Contenido += '<i>Cobrar pago vencido (<b>'+Eventos.NoParcialidad+'</b> de <b>'+Eventos.Parcialidades+'</b>) por <span class="FormatToMoney">'+Eventos.Monto+'</span></i></p>';
    Contenido += ( (Eventos.Prospecto) ? '<p><b>Contacto: </b>'+DatoProspecto+'</p>' : '' );
    Contenido += ( (Eventos.Empresa) ? '<p><b>Empresa: </b><i>'+DatoEmpresa+'</i></p>' : '' );
  }

  if(TipoEvento==5){
    Titulo = Eventos.title;
    Contenido += '<p><b>Concepto: </b><i>'+Eventos.Concepto+'</i></p>';
    Contenido += '<i><i class="fa fa-unlock Rojo"></i> La venta requiere ser auditada</p>';
    Contenido += ( (Eventos.Prospecto) ? '<p><b>Contacto: </b><i>'+DatoProspecto+'</i></p>' : '' );
    Contenido += ( (Eventos.Empresa) ? '<p><b>Empresa: </b><i>'+DatoEmpresa+'</i></p>' : '' );
  }

  Contenido = SalesUp.Sistema.StrReplace('<i class="fa fa-bell"></i>','',Contenido);
  Contenido = SalesUp.Sistema.StrReplace('<i class="fa fa-cubes"></i>','',Contenido);
  Contenido = SalesUp.Sistema.StrReplace('<i class="fa fa-calendar"></i>','',Contenido);

  var PopOverId = 'PopOver'+SalesUp.Construye.IdUnico();
  var TemplatePopover = '<div class="popover" id="'+PopOverId+'" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>';

  $Elemento.popover({
    template:TemplatePopover, placement:DireccionPopOver, html:true, container:'body',
    title:Titulo, content:Contenido
  });

  $Elemento.popover('show');

  SalesUp.Variables.ConvierteEnLinksProspectos();

  var $PopOverId = $('#'+PopOverId);
  var Cerrar = true;
  $PopOverId.mouseleave(function(){
    Cerrar = true;
    setTimeout(function(){(Cerrar) ? $PopOverId.hide():'';}, 1000);
  }).mouseenter(function(){
    Cerrar = false;
  }).click(function(){
    $PopOverId.hide();
  });

  setTimeout(function(){(Cerrar) ? $PopOverId.hide():'';}, 4000);
  
  $Elemento.mouseleave(function(){
    Cerrar = true;
    setTimeout(function(){(Cerrar) ? $PopOverId.hide():'';}, 3000);
  }).mouseenter(function(){
    Cerrar = false;
  });
  
} /* /SalesUp.Variables.ActivarPopOver */

SalesUp.Variables.CambiarMes = function(Op){
  $('#CargandoCalendario').fadeIn();
  SalesUp.Sistema.MuestraEspera('#CargandoCalendario', 1);

  SalesUp.Variables.TomaFecha = $Calendario.fullCalendar('getDate');
  SalesUp.Variables.FechaActual = SalesUp.Variables.TomaFecha.format('DD/MM/YYYY');
  var MesActual = SalesUp.Variables.TomaFecha.months();
  var view = $Calendario.fullCalendar('getView');
  SalesUp.Variables.ConfiguracionVista=view.name;
  (!Op.Cambiar) ? Op.Cambiar = false : '';
  (!SalesUp.Variables.BotonTareas) ? SalesUp.Variables.BotonTareas = 'Mis tareas' : '';
  if( (MesActual!=SalesUp.Variables.MesInicial) || (Op.Cambiar==true) ){
    $('#ActivaCitas').html('<i class="fa fa-check-square-o"></i> Citas').attr('data-Citas',1);
    $('#ActivaTareas').html('<i class="fa fa-check-square-o"></i> '+SalesUp.Variables.BotonTareas).attr('data-Tareas',1);
    $('#ActivaTareasAsignadas').html('<i class="fa fa-check-square-o"></i> Tareas asignadas').attr('data-TareasAsignadas',1);
    $('#ActivaRecordatorios').html('<i class="fa fa-check-square-o"></i> Recordatorios').attr('data-Recordatorios',1);

    SalesUp.Variables.MesInicial = MesActual;
    SalesUp.Variables.CambiarFechaCalendario({fecha:SalesUp.Variables.FechaActual, vista:view.name});
    SalesUp.Variables.leerConfiguracionesCalendario();
  }
  setTimeout(function() {
    SalesUp.Sistema.OcultaEspera(); 
    $('#CargandoCalendario').fadeOut();
  }, 1500);
  
}

SalesUp.Variables.CambiarFechaCalendario = function(Op){
  $('#CargandoCalendario').fadeIn();
  SalesUp.Sistema.MuestraEspera('#CargandoCalendario', 1);
  var f = Op.fecha.split('/');
  var iraFecha = f[2]+'-'+f[1]+'-'+f[0];
  SalesUp.Variables.FechaHoy = f[0]+'/'+f[1]+'/'+f[2];
  SalesUp.Variables.CargaDatosCalendario();
  setTimeout(function() {
  $Calendario.fullCalendar( 'gotoDate', iraFecha );
  (Op.vista) ? $Calendario.fullCalendar( 'changeView', Op.vista ): '';
  SalesUp.Sistema.OcultaEspera(); 
  $('#CargandoCalendario').fadeOut();
  }, 1500);
}
  
SalesUp.Variables.VerEvento = function(Op){
  var $Elemento = $(Op.elemento);
  var Calendario = '#'+Op.calendario;
  var TipoEvento = SalesUp.Sistema.StrReplace(' ','', Op.tipo);
  var Check = $Elemento.attr('data-'+TipoEvento);
  
  $(Calendario+' .EventoCita, '+Calendario+' .EventoRecordatorio, '+Calendario+' .EventoTareas, '+Calendario+' .EventoTareasAsignadas').hide();

  if(Check == 1){ $Elemento.html('<i class="fa fa-square-o"></i> '+Op.tipo).attr('data-'+TipoEvento,0); }
  else{ $Elemento.html('<i class="fa fa-check-square-o"></i> '+Op.tipo).attr('data-'+TipoEvento,1); }

  if($(Calendario+' .ActivaCitas').attr('data-Citas') == 1){ $(Calendario+' .EventoCita').show(); }
  if($(Calendario+' .ActivaTareas').attr('data-Tareas') == 1){ $(Calendario+' .EventoTareas').show(); }
  if($(Calendario+' .ActivaRecordatorios').attr('data-Recordatorios') == 1){ $(Calendario+' .EventoRecordatorio').show(); }
  if($(Calendario+' .ActivaTareasAsignadas').attr('data-TareasAsignadas') == 1){ $(Calendario+' .EventoTareasAsignadas').show(); }


} /* /SalesUp.Variables.VerEvento */


SalesUp.Variables.UsuariosSeleccionados = '';
SalesUp.Variables.VerCalendarioUsuario = function(Op){
  var $Elemento = $(Op.elemento);
  var Usuario = $Elemento.text();
  var Activo = $Elemento.attr('data-activo');
  var Icono = '', Dato = '';
  $('#CalendarioPorUsuario').prepend('<div id="CargandoCalendario" class="CargandoCalendario BoxSizing"></div>');
 
  SalesUp.Variables.CambioUsuario = true;
  if(Activo==0){
    Dato = '<i class="fa fa-check-square-o"></i> '+Usuario+' <i class="fa fa-circle-o-notch fa-spin"></i>';
    $Elemento.attr('data-activo',1);
  }else{
    Dato = '<i class="fa fa-square-o"></i> '+Usuario;
    $Elemento.attr('data-activo',0);
  }

  $Elemento.html(Dato);
  
  $('#LtUsuariosVistaCalendario > li').each(function(){
    var Activo = $(this).attr('data-activo');
    var id = $(this).attr('data-id');
    SalesUp.Variables.UsuariosSeleccionados = SalesUp.Sistema.StrReplace(id+',','',SalesUp.Variables.UsuariosSeleccionados);
    (Activo==1) ? SalesUp.Variables.UsuariosSeleccionados = SalesUp.Variables.UsuariosSeleccionados + id + ',' : ''; 
  });
  
  SalesUp.Variables.IdUsuario = SalesUp.Variables.UsuariosSeleccionados;
  var view = $Calendario.fullCalendar('getView');
  setTimeout(function(){
    clearTimeout(reiniciarConsultaMisEventos);
    SalesUp.Variables.CargaDatosCalendario();
    $Calendario.fullCalendar( 'changeView', view.name );
    $('.fa-circle-o-notch.fa-spin').remove();  
  }, 100);
} /* /VerCalendarioUsuario */

SalesUp.Variables.TemplateOpcion = '<option value="{{Id}}{{IdUsuario}}">{{Grupo}}{{Usuario}}</option>';
SalesUp.Variables.TemplateOpcionGrupos = '<option value="{{IdGrupo}}">{{Grupo}}</option>';

SalesUp.Variables.SeleccionaGrupo = function(Op){
  SalesUp.Variables.IdGrupo = Op.v;
  SalesUp.Variables.jsonUsuariosGrupos = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/jsonUsuariosPorGrupos.dbsp', Parametros:'IDG='+SalesUp.Variables.IdGrupo, DataType:'json'}); 
  var Pasa = false;
  if(Op.t==1){
    $('#LtUsuarios').html('');
    SalesUp.Construye.ConstruyemeUn({
      Control: 'select', Nuevo: false, IdControl: 'LtUsuarios',
      Template: SalesUp.Variables.TemplateOpcion, SeleccioneOpcion : true,
      Datos: SalesUp.Variables.jsonUsuariosGrupos.jsonDatos
    });  
    Pasa = true;
  }
  
  if(Op.t==2){
    $('#LtUsuariosVistaCalendario').html('');
    SalesUp.Construye.ConstruyemeUn({
      Control: 'ul', Nuevo: false, IdControl: 'LtUsuariosVistaCalendario',
      Template: SalesUp.Variables.TemplateLiOpcion,
      Datos: SalesUp.Variables.jsonUsuariosGrupos.jsonDatos
    });

    var UsuariosSeleccionados = SalesUp.Variables.IdUsuario.split(',');
    $.each(UsuariosSeleccionados, function(i,Id){
      var $Elemento = $('#LtUsuariosVistaCalendario li[data-id="'+Id+'"]');
      $Elemento.html('<i class="fa fa-check-square-o"></i> '+$Elemento.text()).attr('data-activo',1);
    });
    Pasa = true;
  }

  //SalesUp.Variables.IdUsuario = '';
  if(Pasa){
    SalesUp.Variables.FechaHoy = moment().format("DD/MM/YYYY");
    //SalesUp.Variables.CargaDatosCalendario();  
  }
 
} /* /SalesUp.Variables.SeleccionaGrupo */

SalesUp.Variables.SeleccionaUsuario = function(Op){
  SalesUp.Variables.IdUsuario = Op.v;
  SalesUp.Variables.CambioUsuario = true;
  
  if(SalesUp.Variables.SessionIdUsuario!=SalesUp.Variables.IdUsuario){
    $('.ActivaTareasAsignadas').hide();
    SalesUp.Variables.BotonTareas = 'Tareas';
    SalesUp.Variables.EsUsuarioSession = false;
    $('#ActivaTareas').addClass('TareasDeOtros');
  }else{
    $('.ActivaTareasAsignadas').show();
    SalesUp.Variables.BotonTareas = 'Mis tareas';
    SalesUp.Variables.EsUsuarioSession = true;
    $('#ActivaTareas').removeClass('TareasDeOtros');
  }
  SalesUp.Variables.CambiarMes({Cambiar:true});
} /* /SalesUp.Variables.SeleccionaGrupo */

SalesUp.Variables.CargaGrupos = function(){
  SalesUp.Variables.jsonGrupos = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/jsonGruposAutorizados.dbsp', DataType:'json'});
  $('#LtGrupos, #LtGruposVistaCalendario, #v3Grupos ').html('');
  SalesUp.Construye.ConstruyemeUn({
    Control: 'select', Nuevo: false, IdControl: 'LtGrupos',
    Template: SalesUp.Variables.TemplateOpcionGrupos,
    Datos: SalesUp.Variables.jsonGrupos.jsonDatos
  });

  SalesUp.Construye.ConstruyemeUn({
    Control: 'select', Nuevo: false, IdControl: 'LtGruposVistaCalendario',
    Template: SalesUp.Variables.TemplateOpcionGrupos,
    Datos: SalesUp.Variables.jsonGrupos.jsonDatos
  });

  SalesUp.Construye.ConstruyemeUn({
    Control: 'select', Nuevo: false, IdControl: 'v3Grupos', SeleccioneOpcion : true,
    Template: SalesUp.Variables.TemplateOpcionGrupos,
    Datos: SalesUp.Variables.jsonGrupos.jsonDatos
  });

} /* /SalesUp.Variables.CargaGrupos */

SalesUp.Variables.CargaUsuarios = function(){
  SalesUp.Variables.jsonUsuariosGrupos = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/jsonUsuariosPorGrupos.dbsp', Parametros:'IDG='+SalesUp.Variables.IdGrupo+'&IDU='+SalesUp.Variables.IdUsuario, DataType:'json'}); 
  $('#LtUsuariosVistaCalendario, #LtUsuarios, #v3Usuarios').html('');
  
  SalesUp.Construye.ConstruyemeUn({
    Control: 'select', Nuevo: false, IdControl: 'LtUsuarios', SeleccioneOpcion : true,
    Template: SalesUp.Variables.TemplateOpcion,
    Datos: SalesUp.Variables.jsonUsuariosGrupos.jsonDatos
  });

  SalesUp.Variables.TemplateLiOpcion = '<li class="Pointer Ellipsis BoxSizing" data-id="{{IdUsuario}}" data-activo="0" onclick="SalesUp.Variables.VerCalendarioUsuario({elemento:this});">';
  SalesUp.Variables.TemplateLiOpcion += '<i class="fa fa-square-o"></i> ';
  SalesUp.Variables.TemplateLiOpcion += '{{Usuario}}';
  SalesUp.Variables.TemplateLiOpcion += '</li>';

  SalesUp.Construye.ConstruyemeUn({
    Control: 'ul', Nuevo: false, IdControl: 'LtUsuariosVistaCalendario',
    Template: SalesUp.Variables.TemplateLiOpcion,
    Datos: SalesUp.Variables.jsonUsuariosGrupos.jsonDatos
  });

} /* /SalesUp.Variables.CargaUsuarios */

SalesUp.Variables.TablaTareasRecordatorios = function(Op){
  var jsonEventos = Op.Eventos;
  
  SalesUp.Sistema.MuestraEspera('#TareasRecordatorios',1);
  
  SalesUp.Variables.HtmlTablaTareasRecordatorios = '<table id="TableTareasRecordatorios" class="simple">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<thead><tr>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen" style="width:20px;"></td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="TdCheckOpciones BoxSizing Pointer">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += ' <span class="LtMenuAcciones" data-activo="0">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <i onclick="SalesUp.Variables.SeleccionarTodosChecks({Elemento:this});" class="fa fa-check-square"></i>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <i onclick="SalesUp.Variables.SeleccionarTodosChecks({Elemento:this});" class="fa fa-square"></i>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <i onclick="SalesUp.Variables.AbrirMenuAccionesMultiples({Elemento:this});" class="fa fa-chevron-circle-down"></i>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <ul style="display: none;" class="LtOpcionesMult">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '     <li style="border-radius:10px;">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '       <a onclick="SalesUp.Variables.MarcarRecordatoriosRealizados({Evento:event});" href="#"><i class="fa fa-check"></i> Marcar como realizado</a>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '     </li>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   </ul>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += ' </span>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen" style="width:100px;">Fecha</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen" style="width:50px;">Hora</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td>Contacto / Empresa</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td>Concepto</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td>Estado</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen">De / Para</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td style="width:35px;"></td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '</tr></thead>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<tbody></tbody></table>';

  $('#TareasRecordatorios').html(SalesUp.Variables.HtmlTablaTareasRecordatorios);

  SalesUp.Variables.HtmlTareasRecordatorios = SalesUp.Sistema.CargaDatos({Link:'/privado/Vista/TemplateRowTareasRecordatorios.dbsp', Almacen:'TemplateRowTareasRecordatorios'});

  var jsonListaEventos = _.reject(jsonEventos , function(d){ return _.size(d) == 0; });

  SalesUp.Construye.ReemplazaTemplate({
    Template: SalesUp.Variables.HtmlTareasRecordatorios,
    Datos: jsonListaEventos,
    Destino: '#TableTareasRecordatorios tbody'
  });

  SalesUp.Variables.GeneraNumeroFila();
  
  if( _.size(jsonListaEventos) == 0 ){ SalesUp.Construye.SinResultados({Destino:'#TareasRecordatorios'}); }
  
  SalesUp.Variables.ConvierteEnLinksProspectos();

  SalesUp.Sistema.IniciaPlugins();

  $('span[data-evento="Recordatorio"][data-duenio=""]').remove();

} /* /SalesUp.Variables.TablaTareasRecordatorios */


SalesUp.Variables.ConvierteEnLinksProspectos = function(){
  $('.ContactosCitas').each(function(){
    var $this = $(this);
    var Contactos = $this.attr('data-contacto');
    var Ids = $this.attr('data-ids');
    var Tks = $this.attr('data-tk');

    var splitIds = Ids.split(',');
    var splitContactos = Contactos.split(',');
    var splitTks = Tks.split(',');
    var DatosContactos = '';
    
    $.each(splitIds, function(i,v){
      var UrlLink = '/privado/prospectos-visualizar.dbsp?tkp='+splitTks[i]+'&idprospecto='+splitIds[i];
      DatosContactos += '<span class="Pointer" onclick="window.open('+"'"+UrlLink+"'"+','+"'_self'"+');"><b>'+splitContactos[i]+'</b></span>, ';
    });

    DatosContactos = DatosContactos.substr(0,DatosContactos.length-2);
    $this.after(DatosContactos);
    $this.remove();
  });
}/*SalesUp.Variables.ConvierteEnLinksProspectos*/

SalesUp.Variables.IraEvento = function(Op){
  var $Elemento = $(Op.Elemento);
  var Evento;

  if(($('#VistaCombinada').is(':visible'))||($('#VistaCalendario').is(':visible'))){
    Evento =  _.findWhere(SalesUp.Variables.ListaEventos.jsonDatos, {'id':Op.id});
  }
  
  if($('#VistaTareasRecordatorios').is(':visible')){
   Evento = _.findWhere(SalesUp.Variables.ModeloListaEventos.jsonDatos, {'id':Op.id});
  }
  
  SalesUp.Variables.AlertaEvento({Elemento:Op.Elemento, Evento:Evento});
} /* /SalesUp.Variables.IraEvento */

SalesUp.Variables.ActivarPopOverInformativo = function(Op){
  var $Elemento = $(Op.Elemento);
  /*$Elemento.removeAttr('onmouseenter');*/
  var id = $Elemento.attr('data-id');
  var Evento;

  if(($('#VistaCombinada').is(':visible'))||($('#VistaCalendario').is(':visible'))){
    Evento =  _.findWhere(SalesUp.Variables.ListaEventos.jsonDatos, {'id':id});
  }
  
  if($('#VistaTareasRecordatorios').is(':visible')){
    Evento = _.findWhere(SalesUp.Variables.ModeloListaEventos.jsonDatos, {'id':id});
  }

  SalesUp.Variables.ActivarPopOver({Elemento:$Elemento, Evento:Evento, PopOverLugar:'right'});
}

SalesUp.Variables.VistaCombinada = function(){
  SalesUp.Sistema.MuestraEspera('#Calendario',1);
  SalesUp.Sistema.MuestraEspera('#TareasRecordatorios',1);
  
  $Calendario = $('#Calendario');
  SalesUp.Variables.IdUsuario = SalesUp.Variables.SessionIdUsuario;
  SalesUp.Variables.EsUsuarioSession = true;

  $('#LtGrupos').val(SalesUp.Variables.SessionIdGrupo);
  SalesUp.Variables.SeleccionaGrupo({v:SalesUp.Variables.SessionIdGrupo, t:1});
  
  setTimeout(function(){
    SalesUp.Variables.FechaHoy =moment().format("DD/MM/YYYY");   
    SalesUp.Variables.CargaDatosCalendario();
    SalesUp.Sistema.IniciaPlugins();
    SalesUp.Sistema.OcultaEspera();
    $('#LtUsuarios').val(SalesUp.Variables.SessionIdUsuario);
    $('.BoxBotones').show();
  }, 10);

} /* /SalesUp.Variables.VistaCombinada */

SalesUp.Variables.VistaCalendario = function(){
  SalesUp.Variables.EsUsuarioSession = false;
  SalesUp.Sistema.MuestraEspera('#CalendarioPorUsuario',1);
  $Calendario = $('#CalendarioPorUsuario');

  $('#LtUsuariosVistaCalendario li .fa').each(function(){
    $(this).addClass('fa-square-o')
    .removeClass('fa-check-square-o')
    .parent().attr('data-activo',0);
  });
  
  SalesUp.Variables.IdUsuario = SalesUp.Variables.SessionIdUsuario;

  var $Elemento = $('li[data-id="'+SalesUp.Variables.SessionIdUsuario+'"]');
  $Elemento.html('<i class="fa fa-check-square-o"></i> '+$Elemento.text()).attr('data-activo',1);
  SalesUp.Variables.UsuariosSeleccionados = SalesUp.Variables.IdUsuario+','
  setTimeout(function(){
    SalesUp.Variables.FechaHoy = moment().format("DD/MM/YYYY");
    SalesUp.Variables.CargaDatosCalendario();
    SalesUp.Sistema.IniciaPlugins();
    SalesUp.Sistema.OcultaEspera();
    $('.BoxBotones').show();
  }, 10);

} /* /SalesUp.Variables.VistaCalendario */

SalesUp.Variables.VistaTareasRecordatorios = function(){

  var iDu = SalesUp.Variables.IdUsuario;
  SalesUp.Variables.CargaUsuariosAutorizados();
  SalesUp.Variables.startPendientes = 1;
  SalesUp.Variables.CargaListaTareasRecordatorios({ Idu:iDu, Rango:3 });

} /* /SalesUp.Variables.VistaTareasRecordatorios */

SalesUp.Variables.startPendientes = 1;
SalesUp.Variables.CargaListaTareasRecordatorios = function(Op){
  var u = SalesUp.Variables.SessionIdUsuario;
  var Rango = 3;

  if(SalesUp.Variables.CambioUsuario){

    SalesUp.Variables.EliminarFiltros({Recargar:false});
    SalesUp.Variables.GuardaConstruyeFiltros({
      Filtro:4, Valor:10, 
      Rango1:SalesUp.Variables.RangoInicio, 
      Rango2:SalesUp.Variables.RangoFin
    });
    
    if(SalesUp.Variables.IdUsuario.indexOf(',')>0){
      var splitValue = SalesUp.Variables.IdUsuario.split(',');
      $.each(splitValue,function(i,v){
        SalesUp.Variables.GuardaConstruyeFiltros({
          Filtro:2, Valor:v
        });
      });
    }else{
      SalesUp.Variables.GuardaConstruyeFiltros({
        Filtro:2, Valor:SalesUp.Variables.IdUsuario
      });  
    }
  }

  if(SalesUp.Variables.startPendientes==1){
    SalesUp.Sistema.MuestraEspera('#ContenedorTareasRecordatorios',1);
  }
  
  SalesUp.Variables.HtmlTablaTareasRecordatorios = '<table id="TablaTareasRecordatorios" class="simple">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<thead><tr>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen" style="width:20px;"></td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="TdCheckOpciones BoxSizing Pointer">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += ' <span class="LtMenuAcciones" data-activo="0">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <i onclick="SalesUp.Variables.SeleccionarTodosChecks({Elemento:this});" class="fa fa-check-square"></i>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <i onclick="SalesUp.Variables.SeleccionarTodosChecks({Elemento:this});" class="fa fa-square"></i>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <i onclick="SalesUp.Variables.AbrirMenuAccionesMultiples({Elemento:this});" class="fa fa-chevron-circle-down"></i>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   <ul style="display: none;" class="LtOpcionesMult">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '     <li style="border-radius:10px;">';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '       <a onclick="SalesUp.Variables.MarcarRecordatoriosRealizados({Evento:event});" href="#"><i class="fa fa-check"></i> Marcar como realizado</a>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '     </li>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '   </ul>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += ' </span>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen" style="width:100px;">Fecha</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen" style="width:50px;">Hora</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td>Contacto / Empresa</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td>Concepto</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td>Estado</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td class="tCen">De / Para</td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<td style="width:35px;"></td>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '</tr></thead>';
  SalesUp.Variables.HtmlTablaTareasRecordatorios += '<tbody></tbody></table>';

  if(SalesUp.Variables.startPendientes==1){
    $('#ContenedorTareasRecordatorios').html(SalesUp.Variables.HtmlTablaTareasRecordatorios);
    $('#TablaTareasRecordatorios').after(SalesUp.Sistema.unMomento());
  }
  
  setTimeout(function() {
    SalesUp.Variables.GuardaConstruyeFiltros({});
    SalesUp.Variables.ModeloListaEventos = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/jsonMisEventosConFiltros.dbsp', Parametros:'&start='+SalesUp.Variables.startPendientes+'&idu='+u+'&r='+Rango, DataType:'json'});
    SalesUp.Variables.HtmlTareasRecordatorios = SalesUp.Sistema.CargaDatos({Link:'/privado/Vista/TemplateRowTareasRecordatorios.dbsp', Almacen:'TemplateRowTareasRecordatorios'});
    SalesUp.Sistema.CargaDatosAsync({link:'/privado/vacio.dbsp',dataType:'html'});
    var jsonListaEventos = _.reject(SalesUp.Variables.ModeloListaEventos.jsonDatos , function(d){ return _.size(d) == 0; });
    var jsonTotalEventos = _.reject(SalesUp.Variables.ModeloListaEventos.Registros , function(d){ return _.size(d) == 0; });

    jsonListaEventos = _.sortBy(jsonListaEventos , function(j){ return j.DTF; });

    if(SalesUp.Variables.startPendientes==1){
      $('#TablaTareasRecordatorios tbody').html('');
    }

    SalesUp.Construye.ReemplazaTemplate({
      Template: SalesUp.Variables.HtmlTareasRecordatorios,
      Datos: jsonListaEventos,
      Destino: '#TablaTareasRecordatorios tbody'
    });

    $('#TablaTareasRecordatorios').find('#Esperando').remove();
    

    var TotalEventos = 0;
    $.each(jsonTotalEventos, function(i,v){
      TotalEventos += parseInt(v.Registros);
    });
    
    var VerMas = '';

    SalesUp.Variables.GeneraNumeroFila();

    if ( _.size($('#TablaTareasRecordatorios tbody tr')) < TotalEventos){
      VerMas += '<div class="w100 tCen Pointer" onclick="SalesUp.Variables.VerMasEventos({ Elemento:this });">';
      VerMas += '<span class="Btn Btn-flat-Aceptar Btn-tiny" id="VerMasEventos">';
      VerMas += '<i class="fa fa-angle-down fa-lg"></i> <b>Ver m&aacute;s</b>';
      VerMas += '</span>';
      VerMas += '</div>';
      $('#TablaTareasRecordatorios').after(VerMas);
    }

    if( _.size(jsonListaEventos) == 0 ){ SalesUp.Construye.SinResultados({Destino:'#ContenedorTareasRecordatorios'}); }
    
    SalesUp.Variables.ConvierteEnLinksProspectos();
    $('span[data-evento="Recordatorio"][data-duenio=""]').remove();
    SalesUp.Sistema.IniciaPlugins();
  }, 100);
setTimeout(function() {SalesUp.Sistema.OcultaEspera();}, 200);

} /* /SalesUp.Variables.CargaListaTareasRecordatorios */

SalesUp.Variables.GeneraNumeroFila = function(){
  var VistaActiva = '#VistaCombinada';
  ($('#VistaTareasRecordatorios').is(':visible')) ? VistaActiva = '#VistaTareasRecordatorios':'';

  var $NumFila = $(VistaActiva).find('.NumFila'), $Fila;
  
  //var $Padre = $Elemento.closest('.LtMenuAcciones');
  for (var i = 0, j = $NumFila.length ; i < j; i++){
    $Fila = $($NumFila[i]);
    $Fila.html(i+1);
  };
}

SalesUp.Variables.SeleccionarTodosChecks = function(Op){
  var $Elemento = $(Op.Elemento);
  var VistaActiva = '#VistaCombinada';
  var $Padre = $Elemento.closest('.LtMenuAcciones');
  var Activo = 1;
  ($Padre.attr('data-activo')=='1') ? Activo = 0 : '';

  ($('#VistaTareasRecordatorios').is(':visible')) ? VistaActiva = '#VistaTareasRecordatorios':'';
  
  $.each($(VistaActiva+' .CheckBox'), function(i,v){
    var $Check = $(v);
    if(Activo){
      $Check.prop('checked', true);
      SalesUp.Variables.MarcarRowSeleccionado({Elemento:v});
    }else{
      $Check.prop('checked', false);
      SalesUp.Variables.MarcarRowSeleccionado({Elemento:v});
    }
  });
  
  $Padre.attr('data-activo',Activo);

}/*SalesUp.Variables.SeleccionarTodosChecks*/

SalesUp.Variables.MarcarRowSeleccionado = function(Op){
  var $Check = $(Op.Elemento);
  var $row = $Check.closest('tr');
  $row.removeClass('seleccionado');
  ($Check.is(':checked')) ? $row.addClass('seleccionado'):'';
  $('.LtOpcionesMult').slideUp(500);
}


SalesUp.Variables.AbrirMenuAccionesMultiples = function(Op){
  var $Elemento = $(Op.Elemento);
  var $MenuAcciones = $Elemento.next();

  if(!SalesUp.Variables.RecorreChecksActivos()){
    SalesUp.Construye.MuestraAlerta({ TipoAlerta:'AlertaModal', Alerta:'Debe selecccionar al menos un registro.', Titulo:'<i class="fa fa-warning fa-lg"></i> �Atenci�n!', Ancho:'350px'});
    return false;
  }

  if($MenuAcciones.is(':visible')){
    $MenuAcciones.slideUp(500);
  }else{
    $MenuAcciones.slideDown(500);
  }
}

SalesUp.Variables.RecorreChecksActivos = function(){
  var VistaActiva = '#VistaCombinada';
  ($('#VistaTareasRecordatorios').is(':visible')) ? VistaActiva = '#VistaTareasRecordatorios':'';
  SalesUp.Variables.ListaChecksActivos = '';
  $.each($(VistaActiva+' .CheckBox'), function(i,v){
    var $Check = $(v);
    if($Check.is(':checked')){
      SalesUp.Variables.ListaChecksActivos += SalesUp.Sistema.SoloNumero($Check.attr('data-id'))+',';
    }
  });
  return SalesUp.Variables.ListaChecksActivos;
}

SalesUp.Variables.MarcarRecordatoriosRealizados = function(Op){
  Op.Evento.preventDefault();
  var ltids = SalesUp.Variables.RecorreChecksActivos();
  $('.LtOpcionesMult').slideUp(500);
  SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryRealizarRecordatorio.dbsp', Parametros:'ltr='+ltids});
  SalesUp.Variables.RecargarDatos();
}

SalesUp.Variables.VerMasEventos = function(Op){
  var $Elemento = $(Op.Elemento);
  SalesUp.Sistema.MuestraEspera($Elemento,1);
  SalesUp.Variables.startPendientes = 50 + SalesUp.Variables.startPendientes;
  SalesUp.Variables.CargaListaTareasRecordatorios({});
  $Elemento.remove();
  SalesUp.Sistema.OcultaEspera();
}

SalesUp.Variables.Filtrar3Vista = function(Op){
  var Valor = Op.Valor;
  if(!Valor){return false;}
  var $Elemento = $(Op.Elemento);
  var Filtro = Op.Filtro;
  var $Rango1 = $('#Rango1');
  var $Rango2 = $('#Rango2');
  var R1 = $Rango1.val();
  var R2 = $Rango2.val();
  SalesUp.Variables.startPendientes = 1;

  if ((Filtro==4)&&(Valor=='10')&&(!R1)&&(!R2)){
    $Elemento.slideUp();
    setTimeout(function() {$('#Rango1, #Rango2').slideDown();}, 500);
    setTimeout(function() {$('#Rango1').focus();}, 800);
    return false;
  }
  
  $('#CerrarFiltro .fa').addClass('fa-spin fa-spinner fa-2x').removeClass('fa-times fa-lg');
  setTimeout(function() {
    SalesUp.Variables.GuardaConstruyeFiltros({Filtro:Filtro, Valor:Valor, Rango1:R1, Rango2:R2});
    SalesUp.Variables.CargaListaTareasRecordatorios({});
    $('#CerrarFiltro .fa').addClass('fa-times fa-lg').removeClass('fa-spin fa-spinner fa-2x');
    $('#FiltroTipo').val(0);
  }, 100);
  
  SalesUp.Variables.ActivaMostrarFiltros();

}/*SalesUp.Variables.Filtrar3Vista*/

SalesUp.Variables.FiltrarPorTexto = function(Op){
  var Evento = Op.Evento, Pasa = false;
  SalesUp.Variables.Eventosss = Evento;
  var Buscar = escape($('#BuscarTexto').val());
  if(!Buscar){$('#BuscarTexto').focus(); return false;}
  
  if((SalesUp.Sistema.NumKeyCode(Evento) == 13)||(Evento.type == 'click')){
    Pasa = true;
  }

  if(Pasa){
    SalesUp.Variables.startPendientes = 1;
    $('#FiltrarPorTexto .fa').addClass('fa-spin fa-spinner fa-2x').removeClass('fa-search fa-lg');
    setTimeout(function() {
      SalesUp.Variables.GuardaConstruyeFiltros({Filtro:7, Valor:Buscar});
      SalesUp.Variables.CargaListaTareasRecordatorios({});
      $('#FiltrarPorTexto .fa').addClass('fa-search fa-lg').removeClass('fa-spin fa-spinner fa-2x');
      $('#FiltroTipo').val(0); $('#BuscarTexto').val('');
      SalesUp.Variables.ActivaMostrarFiltros();
    }, 100);   
  }
}/*SalesUp.Variables.FiltrarPorTexto*/

SalesUp.Variables.CargaUsuariosAutorizados = function(){
  SalesUp.Variables.jsonUsuariosAutorizados = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/jsonUsuariosAutorizados.dbsp', DataType:'json'}).jsonDatos;
  SalesUp.Construye.ConstruyemeUn({
    Control: 'select', Nuevo: false, IdControl: 'UsuariosDe', SeleccioneOpcion : true,
    Template: SalesUp.Variables.TemplateOpcion,
    Datos: SalesUp.Variables.jsonUsuariosAutorizados
  });

  SalesUp.Construye.ConstruyemeUn({
    Control: 'select', Nuevo: false, IdControl: 'UsuariosPara', SeleccioneOpcion : true,
    Template: SalesUp.Variables.TemplateOpcion,
    Datos: SalesUp.Variables.jsonUsuariosAutorizados
  });
}

SalesUp.Variables.GuardaConstruyeFiltros = function(Op){
  var DatosFiltro = '';
  (Op.Filtro) ?  DatosFiltro += 'F='+Op.Filtro:'';
  (Op.Valor) ? DatosFiltro += '&V='+Op.Valor:'';
  (Op.Rango1) ? DatosFiltro += '&R1='+Op.Rango1:'';
  (Op.Rango2) ? DatosFiltro += '&R2='+Op.Rango2:'';
  $('#FiltrosActuales').html('');
  
  
  var jsonEtiquetas = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryGuardarFiltroEventosCalendario.dbsp', Parametros:DatosFiltro, DataType:'json'}).jsonDatos;
  var TemplateEtiquetaFiltro = '<span class="filtro Pointer Tip1" Tip="Quitar filtro" onclick="SalesUp.Variables.QuitarFiltro({Elemento:this, Filtro:{{Tipo}}, Aux:'+"'{{Aux}}'"+' });">{{Texto}} <i class="fa fa-times-circle"></i></span>';
  var ConFiltro = _.size(jsonEtiquetas[0]);

  SalesUp.Construye.ReemplazaTemplate({
    Template: TemplateEtiquetaFiltro,
    Destino: '#FiltrosActuales',
    Datos: jsonEtiquetas
  });

  if(ConFiltro>0){
    $('#FiltrosActuales').append('<span id="EliminarFiltros" class="Pointer Tip1" Tip="Eliminar filtros" onclick="SalesUp.Variables.EliminarFiltros({Elemento:this, Recargar:true});"><i class="fa fa-lg fa-times"></i></span>');  
  }
}/*GuardaConstruyeFiltros*/

SalesUp.Variables.QuitarFiltro = function(Op){
  $Elemento = $(Op.Elemento);
  var Filtro = Op.Filtro;
  var Aux = Op.Aux;
  SalesUp.Variables.startPendientes = 1;
  SalesUp.Variables.CambioUsuario = false;
  SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryQuitarFiltroEventosCalendario.dbsp', Parametros:'F='+Filtro+'&aux='+Aux});
  SalesUp.Variables.CargaListaTareasRecordatorios({});
  $Elemento.fadeOut();
}

SalesUp.Variables.EliminarFiltros = function(Op){
  SalesUp.Variables.startPendientes = 1;
  var Recargar = false;
  (Op.Recargar) ? Recargar = Op.Recargar:'';
  SalesUp.Variables.CambioUsuario = false;
  SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryEliminarTodosFiltrosEvento.dbsp'});
  (Recargar) ? SalesUp.Variables.CargaListaTareasRecordatorios({}): '';
}

SalesUp.Variables.VerPorVista = function(Op){
  (Op.Evento) ? Op.Evento.preventDefault():'';

  var $Elemento = $(Op.Elemento);
  $('.dropdown-menu a').removeClass('Activo');
  $('#VistaCombinada, #VistaCalendario, #VistaTareasRecordatorios, #BotonExportar').hide();
  
  $Elemento.addClass('Activo');

  if(Op.Vista==1){
    SalesUp.Sistema.Almacenamiento({a:'TempVistaCalendario', v:Op.Vista});
    SalesUp.Variables.VistaCombinada();
    $('#VistaCombinada').prepend('<div id="CargandoCalendario" class="CargandoCalendario BoxSizing"></div>');
    $('#VistaCombinada').show();
  }

  if(Op.Vista==2){
    SalesUp.Variables.VistaCalendario(); 
    SalesUp.Sistema.Almacenamiento({a:'TempVistaCalendario', v:Op.Vista});
    $('#VistaCalendario').prepend('<div id="CargandoCalendario" class="CargandoCalendario BoxSizing"></div>');
    $('#VistaCalendario').show();
  }

  if(Op.Vista==3){
    SalesUp.Variables.VistaTareasRecordatorios();
    SalesUp.Sistema.Almacenamiento({a:'TempVistaCalendario', v:Op.Vista});
    $('#VistaTareasRecordatorios, #BotonExportar').show();

  }
  SalesUp.Sistema.MuestraEspera('#CargandoCalendario',1);
}/*SalesUp.Variables.VerPorVista*/

SalesUp.Variables.ColoresEventoCalendario = function(){
  SalesUp.Variables.jsonColores = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/jsonColores.dbsp', DataType:'json', Almacen:'jsonColores'});
  SalesUp.Variables.jsonColores = SalesUp.Variables.jsonColores.jsonDatos;
  SalesUp.Variables.jsonListaUsuarios = SalesUp.Sistema.CargaDatos({Link:'/privado/ajax/jx-json-lista-usuarios.dbsp', DataType:'json', Almacen:'jsonListaUsuarios'});
  SalesUp.Variables.jsonListaUsuarios = SalesUp.Variables.jsonListaUsuarios.LtUsuarios;
  var Estilo='';
  var nU =_.size(SalesUp.Variables.jsonListaUsuarios);
  var ColoresClaros = randomColor({luminosity: 'light',count: nU});
  var ColoresOscuro = randomColor({luminosity: 'dark',count: nU});
  
  $.each(SalesUp.Variables.jsonListaUsuarios, function(i,v){
    var Id = v.IdUsuario;
    var Color = '';
    var Contraste = SalesUp.Sistema.ContrasteColorYIQ(SalesUp.Variables.jsonColores[i].Color);
    Color = 'background:'+SalesUp.Variables.jsonColores[i].Color+' !important;color:'+Contraste+' !important;'; 

    Estilo += '#VistaCalendario .EventoRecordatorio.R'+Id+'{'+Color+'}';
    Estilo += '#VistaCalendario .EventoCita.C'+Id+'{'+Color+'}';
    Estilo += '#VistaCalendario .EventoTareas.T'+Id+'{'+Color+'}';
    Estilo += '#LtUsuariosVistaCalendario li[data-id="'+Id+'"][data-activo="1"]{'+Color+'}'; 
    /* .fa-check-square-o*/
  });
  $('#ColoresEventosVistaCalendario').html(Estilo);

} /* /SalesUp.Variables.ColoresEventoCalendario */



ConfiguracionPicker.onSelect = function(fecha,o){
  var IdPicker = o.id;
  if(IdPicker=='Rango1'){
    setTimeout(function() {$('#Rango2').focus();}, 200);
  }

  if(IdPicker=='Rango2'){
    SalesUp.Variables.Filtrar3Vista({Elemento:this, Valor:10, Filtro:4});
    setTimeout(function() {$('#Rango1, #Rango2').val('');}, 1000);
  }
  
  if((IdPicker=='CalendarioPicker')||(IdPicker=='Datepicker')){
    SalesUp.Variables.CambiarFechaCalendario({fecha:fecha, vista:'agendaDay'});
  }

}

SalesUp.Variables.CargaDatosCalendario = function(){
  //en la condicion le agregue =='' by Hans
    SalesUp.Variables.FechaHoy = (CalendarioConfiguraciones.Fecha=='')?CalendarioConfiguraciones.Fecha:SalesUp.Variables.FechaHoy;

    var VistaCalendarioActiva = $('#VistaCalendario').is(':visible');
     var usuarios=SalesUp.Variables.DameUsuariosActvos();
    SalesUp.Variables.IdUsuario=(VistaCalendarioActiva)?SalesUp.Variables.DameUsuariosActvos() : SalesUp.Variables.IdUsuario;
   

  var DatosParametros = '&idu='+SalesUp.Variables.IdUsuario+'&fechaActual='+SalesUp.Variables.FechaHoy;
  var Asigandos = '&as=0';
  (SalesUp.Variables.EsUsuarioSession) ? Asigandos = '&as=1' : '';
  DatosParametros += Asigandos;
  reiniciarConsultaMisEventos=setTimeout(function() { 
  SalesUp.Variables.ListaEventos = SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/jsonMisEventos.dbsp', Parametros:DatosParametros, DataType:'json'});

  SalesUp.Variables.MiCalendario({eventos:SalesUp.Variables.ListaEventos.jsonDatos});
   }, 1000);
}

SalesUp.Variables.IniciaCalendario = function(){
  $('#Datepicker, #Rango1, #Rango2').datepicker(ConfiguracionPicker);

  IniciaPor = SalesUp.Sistema.Almacenamiento({a:'TempVistaCalendario'});
  (!IniciaPor) ? IniciaPor = '1' : '';
  SalesUp.Variables.VerPorVista({Vista:IniciaPor});
  $('#BoxMasListas .dropdown-menu li:nth-child('+IniciaPor+') a').addClass('Activo');
  $('.BoxBotones').show();
  SalesUp.Variables.ColoresEventoCalendario();
  SalesUp.Variables.MesInicial = moment().months();
}

SalesUp.Variables.RecargarDatos = function(){
  $('.ActivaTareasAsignadas').show();
  $('#ActivaTareas').removeClass('TareasDeOtros');

  if ($('#VistaCombinada').is(':visible')){
    SalesUp.Variables.VistaCombinada();
  }
  if ($('#VistaCalendario').is(':visible')){
    SalesUp.Variables.VistaCalendario(); 
  }
  if($('#VistaTareasRecordatorios').is(':visible')){
    SalesUp.Variables.VistaTareasRecordatorios();
  }

   

}/*SalesUp.Variables.RecargarDatos*/

SalesUp.Variables.ActivarMenuAcciones = function(Op){
  var $Elemento = $(Op.Elemento);
  $Elemento.removeAttr('onmouseenter');
    SalesUp.Variables.MenuAcciones({Elemento:$Elemento});

  $Elemento.mouseenter(function(){
    SalesUp.Variables.MenuAcciones({Elemento:$Elemento});
  }).mouseleave(function(){
    
  });
}/*SalesUp.Variables.ActivarMenuAcciones*/

SalesUp.Variables.EditarRecordatorio = function(Op){
  //console.info(Op);
  var Idr = SalesUp.Sistema.SoloNumero(Op.idr);
    
  SalesUp.Sistema.AbrePopUp({
    Titulo: 'Editar recordatorio',
    Pagina: 'popup_editar_recordatorio.dbsp',
    Parametros:'propio=1&idrecordatorio='+Idr,
    CallBack:'SalesUp.Variables.RecargarDatos',
    Modal:true, ModalAlt:true, Alto:200, Ancho:670
  });
}/*SalesUp.Variables.EditarRecordatorio*/

SalesUp.Variables.RealizarRecordatorio = function(Op){
  var Idr = Op.idr;
  var Idp = Op.idp;
  var Ido = Op.ido;
  var Id = Op.id;
  (!Ido) ? Ido = 0 : '';
  (!Idp) ? Idp = 0 : '';
  
  if (Idp>0){
    SalesUp.Sistema.AbrePopUp({
      Titulo: 'Marcar como realizado',
      Pagina: 'popup_cierre_recordatorio.dbsp',
      Parametros:'propio=1&IdRecordatorio='+Idr+'&IdProspecto='+Idp+'&IdOportunidad='+Ido,
      CallBack:'SalesUp.Variables.RecargarDatos',
      Modal:true, ModalAlt:true, Alto:300, Ancho:620
    });  
  }else{
    SalesUp.Sistema.CargaDatos({Link:'/privado/Modelo/qryRealizarRecordatorio.dbsp', Parametros:'idr='+Idr });
    SalesUp.Variables.EliminarEventoPantalla({Evento:'EventoRecordatorio', Id:Id});
  }

}/*SalesUp.Variables.RealizarRecordatorio*/

SalesUp.Variables.EliminarEventoPantalla = function(Op){
  var $EventoActual, $RowEventoActual, TipoEvento = '', IdEvento='';
  
  (Op.Evento) ? TipoEvento = Op.Evento : '';
  (Op.Id) ? IdEvento = Op.Id : '';
  
  if ($('#VistaCombinada').is(':visible')){
    $EventoActual = $('#Calendario .'+TipoEvento+'.ID'+IdEvento);
    $RowEventoActual = $('#TableTareasRecordatorios .'+TipoEvento+'.ID'+IdEvento);
  }

  if ($('#VistaCalendario').is(':visible')){
    $EventoActual = $('#CalendarioPorUsuario .'+TipoEvento+'.ID'+IdEvento);
  }

  if($('#VistaTareasRecordatorios').is(':visible')){
    $RowEventoActual = $('#TablaTareasRecordatorios .'+TipoEvento+'.ID'+IdEvento);
  }
  
  setTimeout(function(){
    ($EventoActual) ? $EventoActual.addClass('BounceCloseOut'):'';
    ($RowEventoActual) ? $RowEventoActual.css('background','#DC0F24').css('color','#FFFFFF').hide('slow'):'';
    setTimeout(function(){ 
      ($EventoActual) ? $EventoActual.remove():''; 
      ($RowEventoActual) ? $RowEventoActual.remove():''; 
    }, 1300);
  }, 800);
}

SalesUp.Variables.RecordatorioSeguimiento = function(Op){
  var Idr = Op.idr;
  var Idp = Op.idp;
  var Ido = Op.ido;
  var tkp = Op.tkp;
  var tko = Op.tko;

  SalesUp.Sistema.AbrePopUp({
    Titulo: 'Agregar resumen de seguimiento',
    Pagina: 'popup_seguimiento.dbsp',
    Parametros:'propio=1&tkp='+tkp+'&tko='+tko+'&IdRecordatorio='+Idr+'&IdProspecto='+Idp+'