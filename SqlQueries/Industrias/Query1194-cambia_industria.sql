//[session.db|Untyped,session.idempresa|Untyped,tkeliminar|Text,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @TKELIMINAR VARCHAR(255)
SET @TKELIMINAR =  ISNULL(:TKELIMINAR,0)

SELECT * FROM <#SESSION.DB/>.dbo.EMPRESAS_INDUSTRIAS 
WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND TKIND!= @TKELIMINAR
ORDER BY INDUSTRIA   