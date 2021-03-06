//[idempresa|Integer,fecha|Text,bd|Text,]
-- select
DECLARE @SQL VARCHAR(MAX)
DECLARE @IDEMPRESA VARCHAR(1000)
DECLARE @FECHA VARCHAR(1000)
DECLARE @BD VARCHAR(1000)

SET @BD=ISNULL(:BD,'')
SET @IDEMPRESA = CAST(ISNULL(:IDEMPRESA,0) AS VARCHAR(1000))
SET @FECHA = ISNULL(:FECHA,'')

SET @SQL='
SELECT IDCATALOGO, IDEMPRESA, SALESUP_CT.DBO.PreparaCadenaApp2(CATALOGO) AS CATALOGO, SALESUP_CT.DBO.PreparaCadenaApp2(DESCRIPCION) AS DESCRIPCION,VERPROSPECTOS, 
VERVENTAS, VEREMPRESA, AGRUPAR, ENMENU, TIPO, STATUS, INDICE, OPCIONES,TKCA, TKM , '''+@FECHA+''' AS FECHA
FROM '+@BD+'.dbo.CATALOGOS WITH (NOLOCK) WHERE IDEMPRESA = '+@IDEMPRESA+' AND ULTIMAMODIFICACION >= CONVERT(DATETIME,'''+@FECHA+''',20) 
'

EXEC(@SQL)