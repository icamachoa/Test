//[sin_eliminado|Text,ordenamiento|Text,session.idempresa|Untyped,session.db|Untyped,]
--select 
/*protegido*/
DECLARE @ORDENAMIENTO VARCHAR(1000)
DECLARE @SIN_ELIMINADO VARCHAR(1000)
DECLARE @SQL VARCHAR(MAX)
DECLARE @IDEMPRESA INT
SET @SIN_ELIMINADO = ISNULL(:SIN_ELIMINADO, '') 
SET @ORDENAMIENTO = ISNULL(:ORDENAMIENTO, '') 
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>
SELECT @SIN_ELIMINADO = (CASE WHEN @SIN_ELIMINADO IS NULL THEN '' ELSE @SIN_ELIMINADO END)

SET @SQL='
SELECT COUNT (U.IDGRUPO) AS TOTALN, '''+@ORDENAMIENTO+''' as ordenamiento,'''+@SIN_ELIMINADO+''' as SIN_ELIMINADO
 
from 
<#SESSION.DB/>.DBO.usuarios u, 
<#SESSION.DB/>.DBO.usuarios_grupos g
where u.IDEMPRESA='+CAST(@IDEMPRESA AS VARCHAR(1000))+' '+@SIN_ELIMINADO+'
and u.idgrupo = g.idusuariogrupo
'


EXEC (@SQL)