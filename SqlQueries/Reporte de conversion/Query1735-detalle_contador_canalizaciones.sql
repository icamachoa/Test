//[session.idempresa|Untyped,session.idusuario|Untyped,reporteconfig|Text,anio|Text,idagrupacion|Text,paso|Text,fecha_inicio|Text,session.convertcode|Untyped,fecha_fin|Text,session.db|Untyped,]
--SELECT
--select
DECLARE @SESSION_IDEMPRESA INT
DECLARE @SESSION_IDUSUARIO INT
DECLARE @IDREPORTECONFIG INT
DECLARE @PERIODO INT
DECLARE @FECHA_INICIO DATETIME
DECLARE @FECHA_FIN DATETIME
DECLARE @IDAGRUPACION VARCHAR(16)
DECLARE @DB VARCHAR(128)
DECLARE @SQL VARCHAR(MAX)
DECLARE @PASO INT
DECLARE @ANIO INT
DECLARE @TIPO_REPORTE INT /* 0 PAGINACION,  1 DATOS*/

SET @DB =CAST('<#SESSION.DB/>' AS VARCHAR(128))
SET @SESSION_IDEMPRESA=CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @SESSION_IDUSUARIO=CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDREPORTECONFIG=CAST(:REPORTECONFIG AS INT)
SET @ANIO = CAST(:ANIO AS INT)
SET @IDAGRUPACION=CAST(:IDAGRUPACION AS VARCHAR(16))
SET @PASO=CAST(:PASO AS INT)
SET @TIPO_REPORTE = 0


IF(@ANIO > 0)
BEGIN
	 SET @FECHA_INICIO= CONVERT(DATETIME,'01/01/'+CAST(@ANIO AS VARCHAR),103)
   	 SET @FECHA_FIN=DATEADD(SS,-1,CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(DATETIME,'31/12/'+CAST(@ANIO AS VARCHAR),103)+1,103),103))
END
ELSE
BEGIN
	 SET @FECHA_INICIO= CONVERT(DATETIME,:FECHA_INICIO,<#SESSION.CONVERTCODE/>)
   	 SET @FECHA_FIN=DATEADD(SS,-1,CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(DATETIME,:FECHA_FIN,<#SESSION.CONVERTCODE/>)+1,<#SESSION.CONVERTCODE/>),<#SESSION.CONVERTCODE/>))
END

SET @SQL = '  DECLARE  @FECHA_INICIO DATETIME SET  @FECHA_INICIO = CONVERT(DATETIME, '''+CONVERT(VARCHAR(128),@FECHA_INICIO,103)+''', 103)'
SET @SQL = @SQL+'  DECLARE  @FECHA_FIN DATETIME  SET  @FECHA_FIN = CONVERT(DATETIME, '''+CONVERT(VARCHAR(128), @FECHA_FIN,103)+''', 103)'
SET @SQL = @SQL+'   EXEC  '+@DB+'.DBO.SP_REPORTE_EMBUDO_Y_CONVERSIONES_DETALLE_CANALIZACION '
 +CAST(@SESSION_IDEMPRESA AS VARCHAR(128))+','
 +CAST(@SESSION_IDUSUARIO AS VARCHAR(128))+', '
 +CAST(@IDREPORTECONFIG AS VARCHAR(128))+', @FECHA_INICIO, @FECHA_FIN, '
 +CAST(@IDAGRUPACION AS VARCHAR(128))+', '
 +CAST(@PASO AS VARCHAR(128))+', '
 +CAST(@TIPO_REPORTE AS VARCHAR(128))
 
 EXEC (@SQL)
