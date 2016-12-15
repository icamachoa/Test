//[session.db|Untyped,contador|Integer,idorigen|Integer,session.idempresa|Untyped,session.idusuario|Untyped,]
-- SELECT
DECLARE @SQL VARCHAR(MAX)
DECLARE @IDORIGEN VARCHAR(1000)
DECLARE @CONTADOR VARCHAR(1000)
SET @IDORIGEN = CAST(ISNULL(:IDORIGEN,0) AS VARCHAR(1000))
SET @CONTADOR = CAST(ISNULL(:CONTADOR,0) AS VARCHAR(1000))
SET @SQL='
UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION
SET COL'+@CONTADOR+' = ISNULL(CAST(PO.IDORIGEN AS VARCHAR(10)),'+@IDORIGEN+')
FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION PS
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO ON PS.COL'+@CONTADOR+' = PO.ORIGEN AND PO.IDEMPRESA = <#SESSION.IDEMPRESA/>
WHERE PS.IDUSUARIO = <#SESSION.IDUSUARIO/>

SELECT 0 AS CONTEOS, 0 AS TIPO
'
EXEC (@SQL)