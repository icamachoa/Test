//[session.db|Untyped,session.idempresa|Untyped,tk|Text,]
--SELECT
DECLARE @IDEMPRESA INT 
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>

SELECT TITULO, CAST(TKTI AS VARCHAR(256)) AS TK FROM <#SESSION.DB/>.DBO.EMPRESAS_TITULOS WHERE IDEMPRESA= @IDEMPRESA