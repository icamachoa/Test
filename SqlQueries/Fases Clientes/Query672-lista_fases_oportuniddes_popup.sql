//[session.db|Untyped,session.idempresa|Untyped,tk_eliminar|Text,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @TK_ELIMINAR VARCHAR(256)
SET @TK_ELIMINAR = ISNULL(:TK_ELIMINAR,0)
SELECT *,SALESUP_CT.dbo.esCanalizado(TK, TKM) AS esCanalizado from  <#SESSION.DB/>.DBO.OPORTUNIDADES_FASES 
WHERE IDEMPRESA=<#SESSION.IDEMPRESA/>  AND TK != @TK_ELIMINAR
ORDER BY ORDEN
