//[col|Text,session.db|Untyped,session.idusuario|Untyped,]
--select
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @SQL VARCHAR(MAX)
DECLARE @COL VARCHAR(1000)
SET @COL = ISNULL(:COL,'')
SET @SQL = 'SELECT '''+@COL+''' AS COLUMNA, COUNT(*) AS CONTADOR FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> GROUP BY '+@COL+' HAVING COUNT(*)>1'
EXEC (@SQL)