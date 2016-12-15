//[tiposs|Integer,crituser|Text,crituser2|Text,crituser3|Text,periodo_seleccionado|Integer,session.db|Untyped,session.convertcode|Untyped,activas|Integer,contienepalabra|Text,session.idgrupo|Untyped,porcomponente|Text,session.nivel|Untyped,session.idempresa|Untyped,session.idusuario|Untyped,ordenamiento|Text,fecha_desde|Text,fecha_hasta|Text,]
--SELECT
/*protegido*/
DECLARE @ORDENAMIENTO VARCHAR(MAX)
DECLARE @ACTIVAS INT
DECLARE @PERIODO_SELECCIONADO INT
DECLARE @EJECUTIVOS VARCHAR(2024)
DECLARE @FECHA_DESDE DATETIME
DECLARE @FECHA_HASTA DATETIME
DECLARE @CONDICION VARCHAR(MAX)
DECLARE @EXECSQL VARCHAR(MAX)
DECLARE @NIVEL INT
DECLARE @PORCOMPONENTE VARCHAR(MAX)
DECLARE @CONDICIONPORCOMPONENTE VARCHAR(MAX)
DECLARE @CONVERTCODE INT
DECLARE @SESSION_NIVEL INT
DECLARE @SESSION_DB VARCHAR(1024)
DECLARE @CRITUSER VARCHAR(1024)
DECLARE @CRITUSER2 VARCHAR(1024)
DECLARE @CRITUSER3 VARCHAR(1024)
DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @IDGRUPO INT
DECLARE @CONTIENEPALABRA VARCHAR(MAX)
DECLARE @CONDICIONPALABRA VARCHAR(MAX)
DECLARE @TIPOS INT


SET @TIPOS = ISNULL(:TIPOSS, 0)

SET @CRITUSER = ISNULL(:CRITUSER, '')
SET @CRITUSER2 = ISNULL(:CRITUSER2, '')
SET @CRITUSER3 = ISNULL(:CRITUSER3, '')
SET @PERIODO_SELECCIONADO = ISNULL(:PERIODO_SELECCIONADO, 0)
SET @SESSION_DB = '<#SESSION.DB/>' 
SET @CONVERTCODE = <#SESSION.CONVERTCODE/>
SET @ACTIVAS = ISNULL(:ACTIVAS, 0)
SET @CONTIENEPALABRA = ISNULL(:CONTIENEPALABRA,'')
SET @IDGRUPO =ISNULL( '<#SESSION.IDGRUPO/>', 0 )
SET @CONDICION = ''
SET @PORCOMPONENTE=ISNULL(:PORCOMPONENTE,'')
SET @SESSION_NIVEL = <#SESSION.NIVEL/>
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDGRUPO =ISNULL( '<#SESSION.IDGRUPO/>', 0 )
SET @ORDENAMIENTO = REPLACE(ISNULL(:ORDENAMIENTO,''), 'FECHA_INICIO', 'INICIO')


SELECT @FECHA_DESDE = CONVERT(DATETIME,ISNULL(:FECHA_DESDE,''),<#SESSION.CONVERTCODE/>)
SELECT @FECHA_HASTA = CONVERT(DATETIME,ISNULL(:FECHA_HASTA,''),<#SESSION.CONVERTCODE/>)

	   IF(@TIPOS = 1 AND @CRITUSER LIKE '%UM.IDUSUARIO IS NOT NULL%' )
	   		exec  <#SESSION.DB/>.[dbo].[SP_METAS_SECCIONES_GRUPOS] 1,@ORDENAMIENTO, @ACTIVAS, @PERIODO_SELECCIONADO,  @FECHA_DESDE,  @FECHA_HASTA, @PORCOMPONENTE , @CONVERTCODE, @SESSION_NIVEL, @SESSION_DB, @CRITUSER, @CRITUSER2, @CRITUSER3, @IDEMPRESA, @IDUSUARIO, @IDGRUPO, @CONTIENEPALABRA
	   	ELSE
      exec  <#SESSION.DB/>.[dbo].[SP_METAS] 1,@ORDENAMIENTO, @ACTIVAS, @PERIODO_SELECCIONADO,  @FECHA_DESDE,  @FECHA_HASTA, @PORCOMPONENTE , @CONVERTCODE, @SESSION_NIVEL, @SESSION_DB, @CRITUSER, @CRITUSER2, @CRITUSER3, @IDEMPRESA, @IDUSUARIO, @IDGRUPO, @CONTIENEPALABRA
