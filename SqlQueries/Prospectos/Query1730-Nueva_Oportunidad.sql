//[idpeticion|Text,seguimiento|Text,concepto|Text,session.db|Untyped,idprospecto|Integer,session.idusuario|Untyped,idlinea|Integer,idfase|Integer,o|Untyped,session.convertcode|Untyped,session.idempresa|Untyped,pesokb|Untyped,cierreestimado|Untyped,session.nombre|Untyped,session.apellidos|Untyped,session.iniciales|Untyped,monto|Untyped,certeza|Untyped,comision|Untyped,comision_monto|Untyped,amazon|Untyped,cotizacion|Untyped,campo1o|Untyped,campo2o|Untyped,campo3o|Untyped,campo4o|Untyped,campo5o|Untyped,campo6o|Untyped,campo7o|Untyped,campo8o|Untyped,campo9o|Untyped,campo10o|Untyped,campo11o|Untyped,campo12o|Untyped,campo13o|Untyped,campo14o|Untyped,campo15o|Untyped,campo16o|Untyped,campo17o|Untyped,campo18o|Untyped,campo19o|Untyped,campo20o|Untyped,campo21o|Untyped,campo22o|Untyped,campo23o|Untyped,campo24o|Untyped,campo25o|Untyped,campo26o|Untyped,campo27o|Untyped,campo28o|Untyped,campo29o|Untyped,campo30o|Untyped,campo31o|Untyped,campo32o|Untyped,campo35o|Untyped,campo36o|Untyped,campo37o|Untyped,campo38o|Untyped,campo39o|Untyped,campo40o|Untyped,campo41o|Untyped,campo42o|Untyped,campo43o|Untyped,campo44o|Untyped,campo45o|Untyped,campo46o|Untyped,campo47o|Untyped,campo48o|Untyped,campo49o|Untyped,campo50o|Untyped,campo51o|Untyped,campo52o|Untyped,campo53o|Untyped,campo54o|Untyped,campo55o|Untyped,campo56o|Untyped,campo57o|Untyped,campo58o|Untyped,campo59o|Untyped,campo60o|Untyped,campo61o|Untyped,campo62o|Untyped,campo63o|Untyped,campo64o|Untyped,]
--SELECT

DECLARE @CONCEPTO AS VARCHAR(128) 
DECLARE @SEGUIMIENTO AS VARCHAR(MAX)
DECLARE @CIERREESTIMADO DATETIME
DECLARE @IDPETICION VARCHAR(512) = ISNULL(:IDPETICION,'')

SET @SEGUIMIENTO =ISNULL(:seguimiento, '')
SET @CONCEPTO=CAST(ISNULL(:CONCEPTO, '') AS VARCHAR(128))
IF( (SELECT COUNT(*) FROM <#SESSION.DB/>.dbo.OPORTUNIDADES WHERE IDPETICION !='' AND IDPETICION = @IDPETICION) = 0)
BEGIN
  DECLARE @IDOPORTUNIDAD INT, @CONVERTCODE INT, @IDEMPRESA INT, @IDPROSPECTO INT, @TOTAL INT
  DECLARE @IDLINEA INT, @IDUSUARIO INT, @IDFASE INT
  DECLARE @HD_USADO FLOAT, @PESOKB FLOAT
  DECLARE @TKO VARCHAR(MAX)
  
  DECLARE @CAMBIOLOCAL INT
  DECLARE @NOMBRE_QUIEN_CANALIZA VARCHAR(MAX), @ESCANALIZADO VARCHAR(2)
  DECLARE @FECHACANALIZADO DATETIME

  DECLARE @IDMONEDADEFAULT INT
  
  SET @TKO = ''
  SET @IDPROSPECTO = :IDPROSPECTO
  SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
  SET @IDLINEA = ISNULL(:IDLINEA,0)
  SET @IDFASE = ISNULL(:IDFASE,0)
  
  DECLARE @O_CatalogoOpcion1 INT, @O_CatalogoOpcion2 INT, @O_CatalogoOpcion3 INT
  
  SET @O_CatalogoOpcion1 = CAST('<#O-CatalogoOpcion1/>' AS INT)  
  SET @O_CatalogoOpcion2 = CAST('<#O-CatalogoOpcion2/>' AS INT) 
  SET @O_CatalogoOpcion3 = CAST('<#O-CatalogoOpcion3/>' AS INT)

  IF @O_CatalogoOpcion1 = 0 BEGIN SET @O_CatalogoOpcion1 = NULL END
  IF @O_CatalogoOpcion2 = 0 BEGIN SET @O_CatalogoOpcion2 = NULL END
  IF @O_CatalogoOpcion3 = 0 BEGIN SET @O_CatalogoOpcion3 = NULL END

  SET @CONVERTCODE = <#SESSION.CONVERTCODE/>
  SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
  SET @HD_USADO=0
  SET @PESOKB=CAST('<#pesokb/>' AS FLOAT)

  SELECT @IDMONEDADEFAULT = IDEMPRESAMONEDA FROM <#SESSION.DB/>.dbo.MONEDAS WHERE IDEMPRESA = @IDEMPRESA AND PORDEFECTO = 1

  IF('<#cierreestimado/>' = '0')
  BEGIN
  	   SET @CIERREESTIMADO = GETDATE()
  END
  ELSE
  BEGIN
  	   SET @CIERREESTIMADO = CONVERT(DATETIME,'<#cierreestimado/>',@CONVERTCODE)
  END
  
  SELECT @ESCANALIZADO = SALESUP_CT.dbo.esCanalizado(P.TKP, P.TKPM) FROM <#SESSION.DB/>.dbo.PROSPECTOS P WHERE P.IDPROSPECTO = @IDPROSPECTO AND P.IDEMPRESA = @IDEMPRESA
  IF @ESCANALIZADO = '1' OR @ESCANALIZADO = '2' BEGIN SET @NOMBRE_QUIEN_CANALIZA = '<#SESSION.NOMBRE/> <#SESSION.APELLIDOS/> (<#SESSION.INICIALES/>)' SET @FECHACANALIZADO = GETDATE() SET @CAMBIOLOCAL = 1 END
  
  
  INSERT INTO <#SESSION.DB/>.dbo.OPORTUNIDADES
  (
   IDPROSPECTO, IDUSUARIO, CONCEPTO, MONTO, SUBTOTAL, CERTEZA, FECHA_CIERRE, IDFASE, COMISION,
   COMISION_MONTO, IDLINEA_PRODUCTO, AMAZON, IDPETICION,
   IDCATALOGOOPCION1, IDCATALOGOOPCION2, IDCATALOGOOPCION3, CAMBIOLOCAL, USRCANALIZO, CANALIZADOEL,IDEMPRESAMONEDADEFAULT
  )
  VALUES 
  (
   @IDPROSPECTO,@IDUSUARIO, @CONCEPTO, cast (REPLACE('<#monto/>', ' ' , '') as money), cast (REPLACE('<#monto/>', ' ' , '') as money),<#certeza/>,@CIERREESTIMADO, @IDFASE, cast ('<#comision/>' as float)/100,
   cast ('<#comision_monto/>' as money),@IDLINEA,CAST('<#AMAZON>' AS INT), @IDPETICION,
   @O_CatalogoOpcion1, @O_CatalogoOpcion2, @O_CatalogoOpcion3, @CAMBIOLOCAL, @NOMBRE_QUIEN_CANALIZA, @FECHACANALIZADO,@IDMONEDADEFAULT
  )

  SELECT TOP 1 @TKO = TKO, @IDOPORTUNIDAD = IDOPORTUNIDAD, @IDPROSPECTO = IDPROSPECTO FROM <#SESSION.DB/>.dbo.OPORTUNIDADES WHERE IDPROSPECTO = @IDPROSPECTO ORDER BY IDOPORTUNIDAD DESC

  IF (LTRIM(RTRIM('<#cotizacion/>'))!='')
   BEGIN
    INSERT INTO <#SESSION.DB/>.dbo.EMPRESAS_ARCHIVOS_AMAZON (IDEMPRESA,IDUSUARIO,ARCHIVO,PESO,TIPO) VALUES (@IDEMPRESA,@IDUSUARIO,'<#cotizacion/>',@PESOKB,'PO')
    INSERT INTO <#SESSION.DB/>.dbo.PROSPECTOS_ARCHIVOS (IDPROSPECTO,IDOPORTUNIDAD,IDUSUARIO,ARCHIVO,DESCRIPCION,AMAZON,PESO) VALUES (@IDPROSPECTO,@IDOPORTUNIDAD,@IDUSUARIO,'<#cotizacion/>',@CONCEPTO,1,@PESOKB)
    /*UPDATE <#SESSION.DB/>.dbo.EMPRESAS SET HD_USADO=HD_USADO+@PESOKB WHERE IDEMPRESA=@IDEMPRESA*/
   END 


  UPDATE <#SESSION.DB/>.dbo.PROSPECTOS SET ESOPORTUNIDAD = 1, ULTIMAMODIFICACION = GETDATE() WHERE IDPROSPECTO = @IDPROSPECTO
  UPDATE <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS SET ARCHIVADO = 0 WHERE IDPROSPECTO = @IDPROSPECTO AND IDUSUARIO = @IDUSUARIO

  -- Para la comision por linea de vendedor
  IF ((SELECT COUNT(*) FROM <#SESSION.DB/>.dbo.USUARIOS_LINEAS_COMISION WHERE IDLINEA = @IDLINEA AND IDUSUARIO = @IDUSUARIO) = 1)
  BEGIN
    UPDATE <#SESSION.DB/>.dbo.USUARIOS_LINEAS_COMISION SET COMISION = cast ('<#comision/>' as float)/100 WHERE IDLINEA = @IDLINEA AND IDUSUARIO = @IDUSUARIO
  END
  ELSE
  BEGIN
    INSERT INTO <#SESSION.DB/>.dbo.USUARIOS_LINEAS_COMISION (COMISION, IDLINEA, IDUSUARIO) VALUES (cast('<#comision/>' as float)/100, @IDLINEA, @IDUSUARIO)
  END

  INSERT INTO <#SESSION.DB/>.dbo.PROSPECTOS_SEGUIMIENTO (IDPROSPECTO, IDUSUARIO, IDOPORTUNIDAD, COMENTARIO, SISTEMA)
  VALUES 
    (@IDPROSPECTO, @IDUSUARIO, @IDOPORTUNIDAD, 'Convertido en oportunidad con el '+CAST (cast ((<#certeza/>*100) as int) as varchar) + '% de certeza.',1)

  IF NOT  ( LTRIM (@SEGUIMIENTO) IS NULL )
    INSERT INTO <#SESSION.DB/>.dbo.PROSPECTOS_SEGUIMIENTO
    (IDPROSPECTO, IDUSUARIO, IDOPORTUNIDAD, COMENTARIO)
    VALUES 
    (@IDPROSPECTO, @IDUSUARIO, @IDOPORTUNIDAD, @SEGUIMIENTO)
    

  /*SE ACTUALIZAR LOS PERSONALIZABLES*/
  EXEC <#SESSION.DB/>.DBO.SP_ACTUALIZA_CAMPOS_PERSONALIZABLES 2, @IDOPORTUNIDAD, @IDEMPRESA, @CONVERTCODE,
  '<#CAMPO1O/>' , '<#CAMPO2O/>' , '<#CAMPO3O/>' , '<#CAMPO4O/>', 
  '<#CAMPO5O/>' , '<#CAMPO6O/>' , '<#CAMPO7O/>' , '<#CAMPO8O/>', 
  '<#CAMPO9O/>' , '<#CAMPO10O/>', '<#CAMPO11O/>', '<#CAMPO12O/>', 
  '<#CAMPO13O/>', '<#CAMPO14O/>', '<#CAMPO15O/>', '<#CAMPO16O/>', 
  '<#CAMPO17O/>', '<#CAMPO18O/>', '<#CAMPO19O/>', '<#CAMPO20O/>', 
  '<#CAMPO21O/>', '<#CAMPO22O/>', '<#CAMPO23O/>', '<#CAMPO24O/>', '<#CAMPO25O/>', 
  '<#CAMPO26O/>', '<#CAMPO27O/>', '<#CAMPO28O/>', '<#CAMPO29O/>', 
  '<#CAMPO30O/>', '<#CAMPO31O/>', '<#CAMPO32O/>',
  '<#CAMPO35O/>', '<#CAMPO36O/>',
'<#CAMPO37O/>', '<#CAMPO38O/>', '<#CAMPO39O/>', '<#CAMPO40O/>',
'<#CAMPO41O/>', '<#CAMPO42O/>', '<#CAMPO43O/>', '<#CAMPO44O/>',
'<#CAMPO45O/>', '<#CAMPO46O/>', '<#CAMPO47O/>', '<#CAMPO48O/>',
'<#CAMPO49O/>', '<#CAMPO50O/>', '<#CAMPO51O/>', '<#CAMPO52O/>',
'<#CAMPO53O/>', '<#CAMPO54O/>', '<#CAMPO55O/>', '<#CAMPO56O/>',
'<#CAMPO57O/>', '<#CAMPO58O/>', '<#CAMPO59O/>', '<#CAMPO60O/>',
'<#CAMPO61O/>', '<#CAMPO62O/>', '<#CAMPO63O/>', '<#CAMPO64O/>'

  /* Agrega campos auto y uuid  P-(1), O-(2), C-(3), V-(4) */
  EXEC <#SESSION.DB/>.dbo.SP_ACTUALIZA_AUTO_UUID @IDOPORTUNIDAD, 2, @IDEMPRESA 

  /*Genera cotizacion*/
  EXEC <#SESSION.DB/>.dbo.SP_GENERA_COTIZACION @IDEMPRESA, @IDOPORTUNIDAD
  
  DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WHERE IDEMPRESA = @IDEMPRESA AND IDTABLA = 4
  INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES (IDEMPRESA, IDTABLA,FECHAHORA) VALUES(@IDEMPRESA,4,GETDATE()) 

  EXEC <#SESSION.DB/>.dbo.SP_INGRESA_SUCESOS_PROSPECTOS @IDUSUARIO,1,@IDPROSPECTO,@IDEMPRESA,'', ''

  -- se activan las acciones de las fases
  EXEC <#SESSION.DB/>.DBO.SP_EJECUTA_ACCION @IDFASE,@IDPROSPECTO,@IDOPORTUNIDAD  
   
  --EXEC <#SESSION.DB/>.DBO.SP_ACTUALIZA_METAS 1,@IDUSUARIO  
  EXEC <#SESSION.DB/>.DBO.SP_ACTUALIZA_METAS 2, @IDUSUARIO
  
  SELECT @IDOPORTUNIDAD AS IdOportunidad, @TKO AS TKO
END
ELSE
  SELECT 0  AS IdOportunidad, '' AS TKO
  
