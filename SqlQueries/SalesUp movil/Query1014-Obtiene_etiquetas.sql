//[bd|Text,fecha|Text,idempresa|Text,]
 -- select

DECLARE @BD VARCHAR(512)
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @FECHA VARCHAR(512)
DECLARE @IDEMPRESA VARCHAR(1000)
SET @BD = ISNULL(:BD,'')
SET @FECHA =ISNULL(:FECHA,'')
SET @IDEMPRESA=CAST(ISNULL(:IDEMPRESA,0) AS VARCHAR(1000))

SET @EXECSQL = 'SELECT REPLACE(ETIQUETA,''"'','''') AS ETIQUETA, * FROM '+@BD+'.dbo.ETIQUETAS WITH (NOLOCK) WHERE IDEMPRESA = '+@IDEMPRESA+' AND ULTIMAMODIFICACION >= CONVERT(VARCHAR(512),'''+@FECHA+''',20) '
EXEC(@EXECSQL)
