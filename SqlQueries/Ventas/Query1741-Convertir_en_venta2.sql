//[campo1|Text,campo2|Text,campo3|Text,campo4|Text,campo5|Text,campo6|Text,campo7|Text,campo8|Text,campo9|Text,campo10|Text,campo11|Text,campo12|Text,campo13|Text,campo14|Text,campo15|Text,campo16|Text,campo17|Text,campo18|Text,campo19|Text,campo20|Text,CAMPO21|Text,Campo22|Text,Campo23|Text,Campo24|Text,Campo25|Text,Campo26|Text,Campo27|Text,Campo28|Text,Campo29|Text,Campo30|Text,Campo31|Text,Campo32|Text,campo35|Text,campo36|Text,campo37|Text,campo38|Text,campo39|Text,campo40|Text,campo41|Text,campo42|Text,campo43|Text,campo44|Text,campo45|Text,campo46|Text,campo47|Text,campo48|Text,campo49|Text,campo50|Text,campo51|Text,campo52|Text,campo53|Text,campo54|Text,campo55|Text,campo56|Text,campo57|Text,campo58|Text,campo59|Text,campo60|Text,campo61|Text,campo62|Text,campo63|Text,campo64|Text,moneda|Integer,tipodecambio|Numeric,tieneproductos|Integer,o|Untyped,session.convertcode|Untyped,session.idempresa|Untyped,idoportunidad|Integer,fecha_cierre|Untyped,session.db|Untyped,calendariopagos|Untyped,session.idusuario|Untyped,referencia|Text,periodicidad|Untyped,comision_modo|Untyped,campo1o|Untyped,campo2o|Untyped,campo3o|Untyped,campo4o|Untyped,campo5o|Untyped,campo6o|Untyped,campo7o|Untyped,campo8o|Untyped,campo9o|Untyped,campo10o|Untyped,campo11o|Untyped,campo12o|Untyped,campo13o|Untyped,campo14o|Untyped,campo15o|Untyped,campo16o|Untyped,campo17o|Untyped,campo18o|Untyped,campo19o|Untyped,campo20o|Untyped,campo21o|Untyped,campo22o|Untyped,campo23o|Untyped,campo24o|Untyped,campo25o|Untyped,campo26o|Untyped,campo27o|Untyped,campo28o|Untyped,campo29o|Untyped,campo30o|Untyped,campo31o|Untyped,campo32o|Untyped,campo35o|Untyped,campo36o|Untyped,campo37o|Untyped,campo38o|Untyped,campo39o|Untyped,campo40o|Untyped,campo41o|Untyped,campo42o|Untyped,campo43o|Untyped,campo44o|Untyped,campo45o|Untyped,campo46o|Untyped,campo47o|Untyped,campo48o|Untyped,campo49o|Untyped,campo50o|Untyped,campo51o|Untyped,campo52o|Untyped,campo53o|Untyped,campo54o|Untyped,campo55o|Untyped,campo56o|Untyped,campo57o|Untyped,campo58o|Untyped,campo59o|Untyped,campo60o|Untyped,campo61o|Untyped,campo62o|Untyped,campo63o|Untyped,campo64o|Untyped,Campo1C|Untyped,Campo2C|Untyped,Campo3C|Untyped,Campo4C|Untyped,Campo5C|Untyped,Campo6C|Untyped,Campo7C|Untyped,Campo8C|Untyped,Campo9C|Untyped,Campo10C|Untyped]
--SELECT

DECLARE @IDOPORTUNIDAD INT, @CONVERTCODE INT, @IDEMPRESA INT
DECLARE @IDPROSPECTO INT
DECLARE @FECHAMETA DATETIME
DECLARE @IDVENTA INT
DECLARE @HAYVENTA INT
DECLARE @IDMONEDA INT = ISNULL(:MONEDA,0)
DECLARE @TIPODECAMBIO FLOAT 
DECLARE @IDCOMPANIA INT

SET @IDOPORTUNIDAD = :IDOPORTUNIDAD

SET @TIPODECAMBIO = ISNULL(:TIPODECAMBIO,0)

IF(@TIPODECAMBIO = 0) SET @TIPODECAMBIO = 1
IF(@IDMONEDA = 0)BEGIN
  SELECT @IDMONEDA = IDEMPRESAMONEDA FROM <#SESSION.DB/>.dbo.MONEDAS 
  WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND PORDEFECTO = 1
END

DECLARE @CAMPO1 VARCHAR(MAX) = :CAMPO1
DECLARE @CAMPO2 VARCHAR(MAX) = :CAMPO2
DECLARE @CAMPO3 VARCHAR(MAX) = :CAMPO3
DECLARE @CAMPO4 VARCHAR(MAX) = :CAMPO4
DECLARE @CAMPO5 VARCHAR(MAX) = :CAMPO5
DECLARE @CAMPO6 VARCHAR(MAX) = :CAMPO6
DECLARE @CAMPO7 VARCHAR(MAX) = :CAMPO7
DECLARE @CAMPO8 VARCHAR(MAX) = :CAMPO8
DECLARE @CAMPO9 VARCHAR(MAX) = :CAMPO9
DECLARE @CAMPO10 VARCHAR(MAX) = :CAMPO10
DECLARE @CAMPO11 VARCHAR(MAX) = :CAMPO11
DECLARE @CAMPO12 VARCHAR(MAX) = :CAMPO12
DECLARE @CAMPO13 VARCHAR(MAX) = :CAMPO13
DECLARE @CAMPO14 VARCHAR(MAX) = :CAMPO14
DECLARE @CAMPO15 VARCHAR(MAX) = :CAMPO15
DECLARE @CAMPO16 VARCHAR(MAX) = :CAMPO16
DECLARE @CAMPO17 VARCHAR(MAX) = :CAMPO17
DECLARE @CAMPO18 VARCHAR(MAX) = :CAMPO18
DECLARE @CAMPO19 VARCHAR(MAX) = :CAMPO19
DECLARE @CAMPO20 VARCHAR(MAX) = :CAMPO20
DECLARE @CAMPO21 VARCHAR(MAX) = :CAMPO21
DECLARE @CAMPO22 VARCHAR(MAX) = :CAMPO22
DECLARE @CAMPO23 VARCHAR(MAX) = :CAMPO23
DECLARE @CAMPO24 VARCHAR(MAX) = :CAMPO24
DECLARE @CAMPO25 VARCHAR(MAX) = :CAMPO25
DECLARE @CAMPO26 VARCHAR(MAX) = :CAMPO26
DECLARE @CAMPO27 VARCHAR(MAX) = :CAMPO27
DECLARE @CAMPO28 VARCHAR(MAX) = :CAMPO28
DECLARE @CAMPO29 VARCHAR(MAX) = :CAMPO29
DECLARE @CAMPO30 VARCHAR(MAX) = :CAMPO30
DECLARE @CAMPO31 VARCHAR(MAX) = :CAMPO31
DECLARE @CAMPO32 VARCHAR(MAX) = :CAMPO32
DECLARE @CAMPO35 VARCHAR(MAX) = :CAMPO35
DECLARE @CAMPO36 VARCHAR(MAX) = :CAMPO36
DECLARE @CAMPO37 VARCHAR(MAX) = :CAMPO37
DECLARE @CAMPO38 VARCHAR(MAX) = :CAMPO38
DECLARE @CAMPO39 VARCHAR(MAX) = :CAMPO39
DECLARE @CAMPO40 VARCHAR(MAX) = :CAMPO40
DECLARE @CAMPO41 VARCHAR(MAX) = :CAMPO41
DECLARE @CAMPO42 VARCHAR(MAX) = :CAMPO42
DECLARE @CAMPO43 VARCHAR(MAX) = :CAMPO43
DECLARE @CAMPO44 VARCHAR(MAX) = :CAMPO44
DECLARE @CAMPO45 VARCHAR(MAX) = :CAMPO45
DECLARE @CAMPO46 VARCHAR(MAX) = :CAMPO46
DECLARE @CAMPO47 VARCHAR(MAX) = :CAMPO47
DECLARE @CAMPO48 VARCHAR(MAX) = :CAMPO48
DECLARE @CAMPO49 VARCHAR(MAX) = :CAMPO49
DECLARE @CAMPO50 VARCHAR(MAX) = :CAMPO50
DECLARE @CAMPO51 VARCHAR(MAX) = :CAMPO51
DECLARE @CAMPO52 VARCHAR(MAX) = :CAMPO52
DECLARE @CAMPO53 VARCHAR(MAX) = :CAMPO53
DECLARE @CAMPO54 VARCHAR(MAX) = :CAMPO54
DECLARE @CAMPO55 VARCHAR(MAX) = :CAMPO55
DECLARE @CAMPO56 VARCHAR(MAX) = :CAMPO56
DECLARE @CAMPO57 VARCHAR(MAX) = :CAMPO57
DECLARE @CAMPO58 VARCHAR(MAX) = :CAMPO58
DECLARE @CAMPO59 VARCHAR(MAX) = :CAMPO59
DECLARE @CAMPO60 VARCHAR(MAX) = :CAMPO60
DECLARE @CAMPO61 VARCHAR(MAX) = :CAMPO61
DECLARE @CAMPO62 VARCHAR(MAX) = :CAMPO62
DECLARE @CAMPO63 VARCHAR(MAX) = :CAMPO63
DECLARE @CAMPO64 VARCHAR(MAX) = :CAMPO64

DECLARE @TIENEPRODUCTOS INT = ISNULL(:TIENEPRODUCTOS,0)

DECLARE @O_CatalogoOpcion1 INT, @O_CatalogoOpcion2 INT, @O_CatalogoOpcion3 INT

DECLARE @CAMBIOLOCAL INT
DECLARE @ESCANALIZADO VARCHAR(2)

SET @O_CatalogoOpcion1 = CAST('<#O-CatalogoOpcion1/>' AS INT)  
SET @O_CatalogoOpcion2 = CAST('<#O-CatalogoOpcion2/>' AS INT) 
SET @O_CatalogoOpcion3 = CAST('<#O-CatalogoOpcion3/>' AS INT)

IF @O_CatalogoOpcion1 = 0 BEGIN SET @O_CatalogoOpcion1 = NULL END
IF @O_CatalogoOpcion2 = 0 BEGIN SET @O_CatalogoOpcion2 = NULL END
IF @O_CatalogoOpcion3 = 0 BEGIN SET @O_CatalogoOpcion3 = NULL END

SET @CONVERTCODE = <#SESSION.CONVERTCODE/>
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDOPORTUNIDAD = ISNULL(:IDOPORTUNIDAD,0)
SET @HAYVENTA=0
SET @IDVENTA=0

DECLARE @IDMONEDADEFAULT INT
SELECT @IDMONEDADEFAULT = IDEMPRESAMONEDA FROM <#SESSION.DB/>.dbo.MONEDAS WHERE IDEMPRESA = @IDEMPRESA AND PORDEFECTO = 1

SET @FECHAMETA = convert(DATETIME,'<#FECHA_CIERRE/>', <#SESSION.CONVERTCODE/>)
SELECT @IDPROSPECTO=IDPROSPECTO FROM <#SESSION.DB/>.DBO.OPORTUNIDADES WITH(NOLOCK) WHERE IDOPORTUNIDAD = @IDOPORTUNIDAD
SELECT @IDCOMPANIA = IDCOMPANIA FROM <#SESSION.DB/>.DBO.PROSPECTOS WITH(NOLOCK) WHERE IDPROSPECTO = @IDPROSPECTO
SELECT @HAYVENTA=COUNT(*) FROM <#SESSION.DB/>.DBO.VENTAS WITH(NOLOCK) WHERE IDOPORTUNIDAD = @IDOPORTUNIDAD
UPDATE <#SESSION.DB/>.DBO.USUARIOS SET CALENDARIOPAGOS=CAST('<#CALENDARIOPAGOS/>' AS INT) WHERE IDUSUARIO=<#SESSION.IDUSUARIO/>



IF @HAYVENTA=0
BEGIN

   

   SELECT @CAMBIOLOCAL = 1 FROM <#SESSION.DB/>.DBO.OPORTUNIDADES O, <#SESSION.DB/>.DBO.PROSPECTOS P 
   WHERE O.IDOPORTUNIDAD = @IDOPORTUNIDAD AND O.IDPROSPECTO = P.IDPROSPECTO AND O.TKOM IS NOT NULL AND P.TKPM IS NOT NULL

   UPDATE <#SESSION.DB/>.DBO.OPORTUNIDADES  SET
      GANADA=1,
      GANADA_FECHA = convert(DATETIME,'<#FECHA_CIERRE/>', <#SESSION.CONVERTCODE/>),
    IDCATALOGOOPCION1 = @O_CatalogoOpcion1,
    IDCATALOGOOPCION2 = @O_CatalogoOpcion2,
    IDCATALOGOOPCION3 = @O_CatalogoOpcion3, CAMBIOLOCAL = @CAMBIOLOCAL
     WHERE
       IDOPORTUNIDAD = @IDOPORTUNIDAD
  
     INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO  (IDPROSPECTO, IDOPORTUNIDAD, IDUSUARIO, COMENTARIO, SISTEMA)  VALUES 
     (@IDPROSPECTO, @IDOPORTUNIDAD, <#SESSION.IDUSUARIO/> , '�La oportunidad se ha ganado! Hay una venta m�s.',1)
   
   DECLARE @SEGUIM INT
   SELECT Top 1  @SEGUIM = IDSEGUIMIENTO FROM <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO WITH(NOLOCK) WHERE IDPROSPECTO = @IDPROSPECTO AND IDUSUARIO =  <#SESSION.IDUSUARIO/> ORDER BY IDSEGUIMIENTO DESC 

     INSERT INTO <#SESSION.DB/>.DBO.VENTAS 
     (IDOPORTUNIDAD, MONTO, COMISION, FECHAHORA,REFERENCIA, IDUSUARIO, PERIODICIDAD,TIPOCOMISION, CAMBIOLOCAL,IDMONEDA,TIPODECAMBIO,IDEMPRESAMONEDADEFAULT)
     VALUES
     (@IDOPORTUNIDAD,0,0,  convert(DATETIME,'<#FECHA_CIERRE/>', <#SESSION.CONVERTCODE/>), :REFERENCIA,<#SESSION.IDUSUARIO/>,<#PERIODICIDAD/>,<#comision_modo/>, @CAMBIOLOCAL,@IDMONEDA,@TIPODECAMBIO,@IDMONEDADEFAULT)

 
     SELECT TOP 1 @IDVENTA=IDVENTA FROM <#SESSION.DB/>.DBO.VENTAS WITH(NOLOCK) WHERE 
     IDOPORTUNIDAD = @IDOPORTUNIDAD AND FECHAHORA =  convert(DATETIME,'<#FECHA_CIERRE/>', <#SESSION.CONVERTCODE/>) 
     ORDER BY IDVENTA DESC

     UPDATE <#SESSION.DB/>.DBO.PROSPECTOS  SET ESCLIENTE=1, ULTIMAMODIFICACION = GETDATE(), CAMBIOLOCAL=2 WHERE IDPROSPECTO = @IDPROSPECTO 
   EXEC <#SESSION.DB/>.DBO.SP_CONVIERTE_PROSPECTOS_A_CLIENTES @IDPROSPECTO,<#SESSION.IDEMPRESA/>,<#SESSION.IDUSUARIO/>
   
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
   
   /*SE ACTUALIZAR LOS PERSONALIZABLES*/
     EXEC <#SESSION.DB/>.DBO.SP_ACTUALIZA_CAMPOS_PERSONALIZABLES 3, @IDPROSPECTO, @IDEMPRESA, @CONVERTCODE,
     @CAMPO1 , @CAMPO2 , @CAMPO3 , @CAMPO4, 
     @CAMPO5 , @CAMPO6 , @CAMPO7 , @CAMPO8, 
     @CAMPO9 , @CAMPO10, @CAMPO11, @CAMPO12, 
     @CAMPO13, @CAMPO14, @CAMPO15, @CAMPO16, 
     @CAMPO17, @CAMPO18, @CAMPO19, @CAMPO20, 
      @CAMPO21 , @CAMPO22 , @CAMPO23 , @CAMPO24 , @CAMPO25 , 
      @CAMPO26 , @CAMPO27 , @CAMPO28 , @CAMPO29 , 
      @CAMPO30 , @CAMPO31 , @CAMPO32 ,
   @CAMPO35, @CAMPO36,
   @CAMPO37, @CAMPO38, @CAMPO39, @CAMPO40,
   @CAMPO41, @CAMPO42, @CAMPO43, @CAMPO44,
   @CAMPO45, @CAMPO46, @CAMPO47, @CAMPO48,
   @CAMPO49, @CAMPO50, @CAMPO51, @CAMPO52,
   @CAMPO53, @CAMPO54, @CAMPO55, @CAMPO56,
   @CAMPO57, @CAMPO58, @CAMPO59, @CAMPO60,
   @CAMPO61, @CAMPO62, @CAMPO63, @CAMPO64
  
   IF @IDCOMPANIA IS NOT NULL 
    BEGIN
    EXEC <#SESSION.DB/>.DBO.SP_ACTUALIZA_PERSONALIZADOS_COMPANIA @IDCOMPANIA,'<#Campo1C/>','<#Campo2C/>','<#Campo3C/>','<#Campo4C/>','<#Campo5C/>','<#Campo6C/>','<#Campo7C/>','<#Campo8C/>','<#Campo9C/>','<#Campo10C/>'
    END

     INSERT INTO <#SESSION.DB/>.dbo.USUARIOS_SUCESOS  (IDUSUARIO,FECHAHORA,TIPO,TEXTO,IDPROSPECTO,IDOPORTUNIDAD, IDVENTA, IDSEGUIMIENTO) 
   VALUES (<#SESSION.IDUSUARIO/> ,GetDate(),9,'Venta nueva.',@IDPROSPECTO,@IDOPORTUNIDAD, @IDVENTA, @SEGUIM)
   
    EXEC <#SESSION.DB/>.dbo.SP_ACTUALIZA_AUTO_UUID @IDPROSPECTO, 3, @IDEMPRESA
     EXEC <#SESSION.DB/>.dbo.SP_ACTUALIZA_AUTO_UUID @IDOPORTUNIDAD, 4, @IDEMPRESA
   
     DELETE FROM <#SESSION.DB/>.dbo.MODIFICACIONES  WHERE IDTABLA = 4 AND IDEMPRESA = <#SESSION.IDEMPRESA/>
     DELETE FROM <#SESSION.DB/>.dbo.MODIFICACIONES  WITH (ROWLOCK) WHERE IDTABLA = 15 AND IDUSUARIO =<#SESSION.IDUSUARIO/> 
  
     INSERT INTO <#SESSION.DB/>.dbo.MODIFICACIONES  WITH (ROWLOCK) (IDTABLA,IDEMPRESA) VALUES(4,<#SESSION.IDEMPRESA/>) 
     INSERT INTO <#SESSION.DB/>.dbo.MODIFICACIONES  WITH (ROWLOCK) (IDTABLA,IDUSUARIO) VALUES(15,<#SESSION.IDUSUARIO/>) 
END
IF (@IDVENTA>0)
   BEGIN
      INSERT INTO <#SESSION.DB/>.DBO.VENTAS_PRODUCTOS (IDVENTA,IDPRODUCTO,CANTIDAD,PRECIO,INDICEPRECIOLISTA,IDEMPRESAMONEDA,TIPOCAMBIO,SUBTOTAL,DESCUENTO,TOTAL,IMPUESTO1,IMPUESTO2,IMPUESTO3,IMPUESTO4,IMPUESTO5,IMPUESTO6,IMPUESTO7, IMPUESTO8,IMPUESTO9,IMPUESTO10,
            COMISION1,COMISION2,COMISION3,COMISION4,COMISION5,COMISION6,COMISION7,COMISION8,COMISION9,COMISION10, FECHAINICIO, FECHAFIN, FECHADIF,COMENTARIO,CANTIDAD_DESC,PORCENTAJE_DESC,IDEMPRESAMONEDADEFAULT)
    SELECT @IDVENTA,IDPRODUCTO,CANTIDAD,PRECIO,INDICEPRECIOLISTA,@IDMONEDA,TIPOCAMBIO,SUBTOTAL,DESCUENTO,TOTAL,IMPUESTO1,IMPUESTO2,IMPUESTO3,IMPUESTO4,IMPUESTO5,IMPUESTO6,IMPUESTO7, IMPUESTO8,IMPUESTO9,IMPUESTO10,
           COMISION1,COMISION2,COMISION3,COMISION4,COMISION5,COMISION6,COMISION7,COMISION8,COMISION9,COMISION10, FECHAINICIO, FECHAFIN, FECHADIF,COMENTARIO,CANTIDAD_DESC,PORCENTAJE_DESC,@IDMONEDADEFAULT FROM <#SESSION.DB/>.DBO.OPORTUNIDADES_PRODUCTOS WHERE IDOPORTUNIDAD=@IDOPORTUNIDAD
END

IF(@TIENEPRODUCTOS > 0)
BEGIN
   EXEC <#SESSION.DB/>.DBO.SP_NUEVA_EXISTENCIA_PRODUCTOS @IDOPORTUNIDAD
END

SELECT @IDVENTA AS AIDVENTA 

