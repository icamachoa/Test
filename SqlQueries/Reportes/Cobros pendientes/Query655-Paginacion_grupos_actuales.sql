//[session.db|Untyped,session.idempresa|Untyped,]
--SELECT 

DECLARE @IDEMPRESA INT 
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>

SELECT COUNT (IDUSUARIOGRUPO)AS TOTALN 
FROM <#SESSION.DB/>.DBO.USUARIOS_GRUPOS WHERE IDEMPRESA = @IDEMPRESA  
