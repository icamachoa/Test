//[bd|Text,idempresa|Integer,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/

DECLARE @BD VARCHAR(512)
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @IDEMPRESA VARCHAR(1000)
SET @BD = ISNULL(:BD,'')
SET @IDEMPRESA=CAST(ISNULL(:IDEMPRESA,0) AS VARCHAR(1000))

SET @EXECSQL = 'SELECT count(*) as TOTAL,'''+@BD+''' as bd,'''+@IDEMPRESA+''' AS IDEMPRESA  FROM '+@BD+'.dbo.EMPRESAS_TITULOS WITH (NOLOCK) WHERE IDEMPRESA = '+@IDEMPRESA
EXEC(@EXECSQL)