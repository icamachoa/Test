//[session.db|Untyped,fecha_desde|Text,session.convertcode|Untyped,fecha_hasta|Text,session.idusuario|Untyped,]
--UPDATE
/*PROTEGIDO*/
DECLARE @FECHA_DESDE VARCHAR(1000)
DECLARE @FECHA_HASTA VARCHAR(1000)
SET @FECHA_DESDE=ISNULL(:FECHA_DESDE,'')
SET @FECHA_HASTA=ISNULL(:FECHA_HASTA,'')
UPDATE <#SESSION.DB/>.DBO.USUARIOS_DEFAULTS SET DEFAULT_VENTAS_DESDE = CONVERT(DATETIME,@FECHA_DESDE,<#SESSION.CONVERTCODE/>), DEFAULT_VENTAS_HASTA = CONVERT(DATETIME,@FECHA_HASTA,<#SESSION.CONVERTCODE/>)
WHERE IDUSUARIO = <#SESSION.IDUSUARIO/>
