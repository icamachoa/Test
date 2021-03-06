//[bd|Text,idusuario|Integer,fecha|Text,]
-- select

DECLARE @BD VARCHAR(512)
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @IDUSUARIO VARCHAR(1000)
DECLARE @FECHA VARCHAR(1000)
SET @BD = ISNULL(:BD,'')
SET @IDUSUARIO=CAST(ISNULL(:IDUSUARIO,0) AS VARCHAR(1000))
SET @FECHA=ISNULL(:FECHA,'')

SET @EXECSQL = 'SELECT PE.*,'''+@FECHA+''' AS FECHA, '+@IDUSUARIO+'  AS IDUSUARIO '
SET @EXECSQL = @EXECSQL + 'FROM '+@BD+'.dbo.PROSPECTOS P WITH (NOLOCK), '+@BD+'.dbo.PROSPECTOS_ASIGNADOS A, '+@BD+'.dbo.PROSPECTOS_ETIQUETAS PE WITH (NOLOCK) '
SET @EXECSQL = @EXECSQL + 'WHERE A.IDUSUARIO = '+@IDUSUARIO+' AND P.IDPROSPECTO = A.IDPROSPECTO AND A.IDPROSPECTO = PE.IDPROSPECTO AND P.DESCARTADO = 0  AND A.ARCHIVADO = 0 AND P.IDULTIMOSEGUIMIENTO IS NOT NULL ' 
SET @EXECSQL = @EXECSQL + 'AND P.ULTIMAMODIFICACION >= CONVERT(DATETIME,'''+@FECHA+''',20) '
EXEC(@EXECSQL)	