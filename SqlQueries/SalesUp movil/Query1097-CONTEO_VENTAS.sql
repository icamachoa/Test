//[idusuario|Text,bd|Text,fecha|Text,]
--SELECT

DECLARE @BD VARCHAR(512)
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @IDUSUARIO VARCHAR(1000)
DECLARE @FECHA VARCHAR(1000)
SET @IDUSUARIO=CAST(ISNULL(:IDUSUARIO,0) AS VARCHAR(1000))
SET @BD = ISNULL(:BD,'')
SET @FECHA=ISNULL(:FECHA,'')
SET @EXECSQL = 'select count(*) AS TOTAL,'''+@BD+''' AS BD, '''+@FECHA+''' AS FECHA, '+@IDUSUARIO+' AS IDUSUARIO from '+@BD+'.dbo.ventas WITH (NOLOCK) where idusuario = '+@IDUSUARIO+' AND ULTIMAMODIFICACION >= CONVERT(DATETIME,'''+@FECHA+''',20)'
EXEC(@EXECSQL)