//[t|Text,session.db|Untyped,session.idempresa|Untyped,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @T VARCHAR(1000)
SET @T = ISNULL(:T,'')
SELECT TOP 1 * FROM <#SESSION.DB/>.dbo.PROSPECTOS WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> 
AND (TELEFONO = @T OR MOVIL = @T  OR TELEFONO2 = @T  OR TELEFONOCORPORATIVO = @T )
AND @T  !=''
ORDER BY FECHA_ULTIMOSEGUIMIENTO DESC