//[session.db|Untyped,session.idempresa|Untyped,tkcgeliminar|Text,tkcgnuevo|Text,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @TKCGELIMINAR VARCHAR(256)

DECLARE @IDEMPRESA INT

SET @TKCGELIMINAR =  ISNULL(:TKCGELIMINAR,'')

SET @IDEMPRESA =<#SESSION.IDEMPRESA/>


SELECT * FROM <#SESSION.DB/>.dbo.COMPANIAS_GRUPOS
WHERE IDEMPRESA = @IDEMPRESA  AND TKCG NOT IN (@TKCGELIMINAR)
ORDER BY COMPANIAGRUPO