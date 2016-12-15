//[session.idusuario|Untyped,session.idempresa|Untyped,vista|Integer,periodo|Text,parametros|Text,tiporeporte|Integer,session.db|Untyped,moneda|Integer,]
-- Select
/*PROTEGIDO*/

DECLARE @IDUSUARIO INT = <#SESSION.IDUSUARIO/>
DECLARE @IDEMPRESA INT = <#SESSION.IDEMPRESA/>
DECLARE @VISTA INT = ISNULL(:VISTA,0)
DECLARE @PERIODO VARCHAR(256) = ISNULL(:PERIODO,'')
DECLARE @PARAMETROS VARCHAR(10) = ISNULL(:PARAMETROS,'')
DECLARE @TIPOREPORTE INT = ISNULL(:TIPOREPORTE,0)
DECLARE @MONEDA INT = ISNULL(:MONEDA,0)

EXEC <#SESSION.DB/>.DBO.SP_REPORTE_ESTIMACION_VENTAS_DETALLE @IDUSUARIO,@IDEMPRESA,@VISTA,@TIPOREPORTE,@PERIODO,@MONEDA,@PARAMETROS
