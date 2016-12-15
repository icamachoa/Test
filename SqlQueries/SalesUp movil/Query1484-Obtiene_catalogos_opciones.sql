//[idempresa|Integer,fecha|Text,bd|Text,]
-- select

DECLARE @IDEMPRESA VARCHAR(1000)
DECLARE @FECHA VARCHAR(1000)
DECLARE @SQL VARCHAR(MAX)
DECLARE @BD VARCHAR(1000)
SET @BD=ISNULL(:BD,'')
SET @IDEMPRESA = CAST(ISNULL(:IDEMPRESA,0) AS VARCHAR(1000))
SET @FECHA = ISNULL(:FECHA,'')
SET @SQL='
SELECT co.IDCATALOGOOPCION, co.IDCATALOGO, SALESUP_CT.DBO.PreparaCadenaApp2(co.OPCION) AS OPCION,co.TKCO , '''+@BD+''' AS BD, '''+@FECHA+''' AS FECHA, '+@IDEMPRESA+' AS IDEMPRESA
FROM '+@BD+'.dbo.catalogos_opciones co WITH (NOLOCK), '+@BD+'.dbo.catalogos o WITH (NOLOCK) WHERE co.idcatalogo = o.idcatalogo and o.IDEMPRESA = '+@IDEMPRESA+' AND co.ULTIMAMODIFICACION >=CONVERT(DATETIME,'''+@FECHA+''',20)
'
EXEC(@SQL)