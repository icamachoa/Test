//[tkeliminar|Text,session.db|Untyped,session.idempresa|Untyped,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @TKELIMINAR VARCHAR(256)
SET @TKELIMINAR = ISNULL(:TKELIMINAR,0)
SELECT  ORIGEN, TK, TKM,SALESUP_CT.dbo.esCanalizado(TK, TKM) AS esCanalizado 
FROM <#SESSION.DB/>.dbo.PROSPECTOS_ORIGENES 
WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND TK!= @TKELIMINAR
ORDER BY ORIGEN  