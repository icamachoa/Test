//[session.db|Untyped,session.idempresa|Untyped,tipo|Text,]
--select
DECLARE @CRIT VARCHAR(MAX)
DECLARE @SQL VARCHAR(MAX)
DECLARE @CONDICION varchar(max)
DECLARE @TIPO VARCHAR(MAX) 
SET @TIPO= ISNULL (:tipo, '') 
SET @CONDICION= CASE WHEN @TIPO!='' THEN 'AND TIPO='+@TIPO WHEN @TIPO='' THEN ''  END 


SET @SQL = '
select * from  <#SESSION.DB/>.DBO.EMPRESAS_RAZONES_PERDIDA
where IDEMPRESA= <#SESSION.IDEMPRESA/>  ' + @CONDICION + '
order by IDRAZONPERDIDA DESC '

EXEC (@SQL)