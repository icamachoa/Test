//[session.idusuario|Untyped,idpantalla|Integer,session.convertcode|Untyped,session.db|Untyped,session.idempresa|Untyped,]
--SELECT
DECLARE @SQLTXT VARCHAR(MAX)
DECLARE @F_USUARIO VARCHAR(MAX) = ' AND PS.IDUSUARIO = <#SESSION.IDUSUARIO/> '
DECLARE @FILTRO_SEG VARCHAR(MAX) = ''
DECLARE @FECHA_DESDE VARCHAR(128)
DECLARE @FECHA_HASTA VARCHAR(128)
DECLARE @IDPANTALLA INT = ISNULL(:IDPANTALLA,0)

SELECT 
@FECHA_DESDE = CONVERT(varchar(10),DEFAULT_VENTAS_DESDE,<#SESSION.CONVERTCODE/>),
@FECHA_HASTA = CONVERT(VARCHAR(10),DEFAULT_VENTAS_HASTA,<#SESSION.CONVERTCODE/>)
FROM <#SESSION.DB/>.DBO.USUARIOS_DEFAULTS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/>

SELECT @FILTRO_SEG = ISNULL(SQLTXT,'') FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO=<#SESSION.IDUSUARIO> AND IDPANTALLA=@IDPANTALLA

IF(@FILTRO_SEG = '')
BEGIN
	 SET @F_USUARIO = @F_USUARIO + ' AND (PS.FECHAHORA BETWEEN CONVERT(DATETIME,'''+@FECHA_DESDE+''',<#SESSION.CONVERTCODE/>) AND CONVERT(DATETIME,'''+@FECHA_HASTA+''',<#SESSION.CONVERTCODE/>)) '
END
ELSE
BEGIN
	 SET @F_USUARIO = @FILTRO_SEG
END

SET @SQLTXT = 'SELECT PS.FECHAHORA,PS.COMENTARIO, PS.IDUSUARIO, PS.IDOPORTUNIDAD, PS.IDSEGUIMIENTO, PS.LATITUD, PS.LONGITUD, U.INICIALES AS USUARIO,ISNULL(U.NOMBRE,'''')+'' ''+ISNULL(U.APELLIDOS,'''') AS NOMBRE_USUARIO, P.NOMBRE+'' ''+P.APELLIDOS AS PROSPECTO, P.EMPRESA, PS.DIRECCION
FROM <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO PS, <#SESSION.DB/>.DBO.USUARIOS U, <#SESSION.DB/>.DBO.PROSPECTOS P
WHERE PS.IDPROSPECTO = P.IDPROSPECTO AND PS.IDUSUARIO = U.IDUSUARIO
AND U.IDEMPRESA = <#SESSION.IDEMPRESA/> AND (PS.LATITUD IS NOT NULL AND PS.LONGITUD IS NOT NULL) 
AND (PS.LATITUD != '''' AND PS.LONGITUD != '''') AND (PS.LATITUD != ''undefined'' AND PS.LONGITUD != ''undefined'')
'+@F_USUARIO+' ORDER BY PS.IDUSUARIO,PS.FECHAHORA '

EXEC(@SQLTXT)