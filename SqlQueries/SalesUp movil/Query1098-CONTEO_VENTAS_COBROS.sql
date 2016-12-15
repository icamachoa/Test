//[idusuario|Integer,bd|Text,fecha|Text,]
--SELECT

DECLARE @BD VARCHAR(512)
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @IDUSUARIO VARCHAR(1000)
DECLARE @FECHA VARCHAR(1000)
SET @IDUSUARIO=CAST(ISNULL(:IDUSUARIO,0)AS VARCHAR(1000))
SET @BD = ISNULL(:BD,'')
SET @FECHA=ISNULL(:FECHA,'')

SET @EXECSQL = 'SELECT COUNT(*) AS TOTAL, '''+@FECHA+''' AS FECHA, '+@IDUSUARIO+' AS IDUSUARIO, '''+@BD+''' as BD from '+@BD+'.dbo.ventas V WITH (NOLOCK),  '+@BD+'.dbo.ventas_COBROS VC WITH (NOLOCK)'
SET @EXECSQL = @EXECSQL + 'where idusuario = '+@IDUSUARIO+' AND VC.IDVENTA = V.IDVENTA AND VC.ULTIMAMODIFICACION >= CONVERT(DATETIME,'''+@FECHA+''',20)'
EXEC(@EXECSQL)