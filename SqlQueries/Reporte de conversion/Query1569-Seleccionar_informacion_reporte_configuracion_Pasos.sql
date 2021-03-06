//[irepcon|Integer,session.idempresa|Untyped,session.db|Untyped,]
--SELECT
DECLARE @IDREPORTECONFIG INT, @IDEMPRESA INT

SET @IDREPORTECONFIG = CAST(ISNULL(:iRepCon,0) AS INT)
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT RP.IDREPORTEPASO AS IdRePa, RP.Paso, RP.Descripcion, RP.Universo,RP.Naturaleza
FROM <#SESSION.DB/>.dbo.REPORTE_PASOS RP
JOIN <#SESSION.DB/>.dbo.REPORTES_CONFIGURACIONES RC ON RP.IDREPORTECONFIG = RC.IDREPORTECONFIG AND RC.IDEMPRESA = @IDEMPRESA
WHERE RP.IDREPORTECONFIG = @IDREPORTECONFIG ORDER BY RP.PASO

