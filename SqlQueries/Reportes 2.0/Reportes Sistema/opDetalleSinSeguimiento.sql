//[session.idusuario|Untyped,session.idempresa|Untyped,vista|Integer,parametros|Text,moneda|Integer,session.db|Untyped,periodo|Integer,]
-- Select
/*PROTEGIDO*/

DECLARE @IDUSUARIO INT = <#SESSION.IDUSUARIO/>
DECLARE @IDEMPRESA INT = <#SESSION.IDEMPRESA/>
DECLARE @VISTA INT = ISNULL(:VISTA,0)
DECLARE @PARAMETROS VARCHAR(MAX) = ISNULL(:PARAMETROS,'')
DECLARE @PERIODO INT = ISNULL(:PERIODO,0)
DECLARE @MONEDA INT = ISNULL(:MONEDA,0)

EXEC <#SESSION.DB/>.DBO.SP_REPORTE_OP_SINSEGUIMIENTO_DETALLE_MEJORA @IDUSUARIO,@IDEMPRESA,@VISTA,@PERIODO,@MONEDA,@PARAMETROS