//[idempresa|Integer,bd|Text,]
-- select

DECLARE @BD VARCHAR(512)
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @IDEMPRESA VARCHAR(128) = :IDEMPRESA

SET @BD = ISNULL(:BD,'')

SET @EXECSQL = 'SELECT count(*) as TOTAL, '''+@BD+''' AS BD, '''+@IDEMPRESA+''' AS IDEMPRESA FROM '+@BD+'.dbo.EMPRESAS_LINEAS_PRODUCTO WITH (NOLOCK) WHERE IDEMPRESA = CAST('''+@IDEMPRESA+''' AS INT) '

EXEC(@EXECSQL)