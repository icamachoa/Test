//[bd|Text,idempresa|Text,fecha|Text,]
-- select
DECLARE @SQL VARCHAR(MAX)
DECLARE @BD VARCHAR(1000)
DECLARE @IDEMPRESA VARCHAR(1000)
DECLARE @FECHA VARCHAR(1000)
SET @IDEMPRESA=CAST(ISNULL(:IDEMPRESA,0) AS VARCHAR(1000))
SET @FECHA = ISNULL(:FECHA,'')
SET @BD=ISNULL(:BD,'')
SET @SQL='
	SELECT *, '+@IDEMPRESA+' AS IDEMPRESA,'''+@FECHA+''' AS FECHA FROM '+@BD+'.dbo.EMPRESAS_CAMPOS_CONFIGURACION WITH (NOLOCK)
	WHERE IDEMPRESA = '+@IDEMPRESA+' AND ULTIMAMODIFICACION >= CONVERT(DATETIME,'''+@FECHA+''',20) ORDER BY CAMPO
'
--SELECT @SQL
EXEC (@SQL)