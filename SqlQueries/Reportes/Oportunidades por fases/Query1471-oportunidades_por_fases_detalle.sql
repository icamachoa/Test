//[idmoneda|Integer,idusuario|Integer,tku|Text,session.db|Untyped,session.idempresa|Untyped,tipofase|Integer,tiempo|Integer,idfase|Integer,session.idusuario|Untyped,]
--select
DECLARE @IDUSUARIO INT
DECLARE @IDEMPRESA INT
DECLARE @TIPOFASE INT
DECLARE @TIEMPO INT
DECLARE @IDFASE INT
DECLARE @IDMONEDA INT = ISNULL(:IDMONEDA,0)
DECLARE @TKU VARCHAR(128)

SET @IDUSUARIO=CAST(ISNULL(:IDUSUARIO,0) AS INT)

SET @TKU = ISNULL(:TKU, '')
IF @TKU != '' BEGIN SELECT @IDUSUARIO = IDUSUARIO FROM <#SESSION.DB/>.DBO.USUARIOS WHERE CAST(TKU AS VARCHAR(128 )) = @TKU END



SET @IDEMPRESA=CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @TIPOFASE=CAST(ISNULL(:TIPOFASE,0) AS INT) /*0-PROSPECTOS, 1-OPORTUNIDADES, 2-CLIENTES*/
SET @TIEMPO=CAST(ISNULL(:TIEMPO,0) AS INT) /*0-CANTIDAD, 1-MONTO, 2-TIEMPO*/
SET @IDFASE=CAST(ISNULL(:IDFASE,0) AS INT)

EXEC <#SESSION.DB/>.DBO.SP_REPORTE_FASES_DETALLE @IDUSUARIO, @IDEMPRESA, @TIPOFASE, @TIEMPO, @IDFASE, '<#SESSION.IDUSUARIO/>',@IDMONEDA